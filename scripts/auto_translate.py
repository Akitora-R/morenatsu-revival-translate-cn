#!/usr/bin/env python3
"""
Auto-translate RPY files using pre-computed KS embeddings.

Workflow:
1. Load rpy_to_ks_mapping.json
2. Load KS embeddings into memory (numpy)
3. For each RPY file, find translate blocks by block ID
4. Look up mapping to find corresponding KS file
5. Compute embedding for English source, search KS embeddings
6. If similarity >= threshold, insert translation
7. Write back to RPY file

Usage:
    python scripts/auto_translate.py --dry-run --limit 5
    python scripts/auto_translate.py --threshold 0.8
    python scripts/auto_translate.py --file "Day 16.rpy"
"""

import re
import json
import time
import logging
import argparse
import numpy as np
from pathlib import Path
from typing import Optional

# Configure logging
logging.basicConfig(
    level=logging.INFO,
    format="%(asctime)s [%(levelname)s] %(message)s",
    datefmt="%H:%M:%S",
)
log = logging.getLogger(__name__)

RPY_SOURCE = Path("rpy")
MAPPING_FILE = Path("output/texts/rpy_to_ks_mapping.json")
KS_EMBEDDINGS_DIR = Path("output/embeddings/ks_texts")
KS_TEXTS_DIR = Path("output/texts/ks_texts")

TRANSLATE_BLOCK_PATTERN = re.compile(
    r"(translate\s+chinese_simplified\s+)(\w+)(:\s*\n)((?:\s+.*\n)*)",
    re.MULTILINE,
)

SOURCE_COMMENT_PATTERN = re.compile(r'^(\s*)#\s+(?:(\w+)\s+)?"(.*)"$')


def load_mapping() -> dict:
    log.info("Loading mapping file: %s", MAPPING_FILE)
    with open(MAPPING_FILE, encoding="utf-8") as f:
        mapping = json.load(f)
    total = sum(len(v) for v in mapping.values())
    log.info("Mapping loaded: %d RPY files, %d label prefixes", len(mapping), total)
    return mapping


def load_ks_embeddings(ks_file: str) -> Optional[dict]:
    """Load KS embeddings and texts for a given KS file.
    
    Returns dict with:
      - embeddings: numpy array (N, 1024)
      - texts: list of translated Chinese texts
      - source_file: original KS filename
    """
    emb_path = KS_EMBEDDINGS_DIR / f"{ks_file}.jsonl"
    if not emb_path.exists():
        log.warning("Embedding file not found: %s", emb_path)
        return None

    embeddings = []
    texts = []
    with open(emb_path, encoding="utf-8") as f:
        for line in f:
            entry = json.loads(line)
            if "embedding" in entry:
                embeddings.append(entry["embedding"])
                texts.append(entry.get("text", ""))

    if not embeddings:
        log.warning("No embeddings found in %s", emb_path)
        return None

    return {
        "embeddings": np.array(embeddings, dtype=np.float32),
        "texts": texts,
        "source_file": ks_file,
    }


_ks_cache = {}


def get_ks_data(ks_file: str) -> Optional[dict]:
    """Get KS data with caching."""
    if ks_file not in _ks_cache:
        _ks_cache[ks_file] = load_ks_embeddings(ks_file)
    return _ks_cache[ks_file]


def compute_embedding(text: str) -> Optional[list]:
    """Compute embedding for a text using Ollama."""
    import subprocess

    try:
        result = subprocess.run(
            [
                "curl", "-s",
                "http://localhost:11434/api/embed",
                "-d", json.dumps({
                    "model": "qwen3-embedding:4b",
                    "input": text,
                    "dimensions": 1024,
                }),
            ],
            capture_output=True,
            text=True,
            timeout=30,
        )
        if result.returncode != 0:
            log.error("Ollama error: %s", result.stderr)
            return None

        resp = json.loads(result.stdout)
        return resp["embeddings"][0]
    except Exception as e:
        log.error("Embedding computation failed: %s", e)
        return None


def cosine_similarity(query_emb: np.ndarray, matrix: np.ndarray) -> np.ndarray:
    """Compute cosine similarity between query and all rows in matrix."""
    query_norm = np.linalg.norm(query_emb)
    if query_norm == 0:
        return np.zeros(len(matrix))

    matrix_norms = np.linalg.norm(matrix, axis=1)
    dot_products = matrix @ query_emb
    similarities = dot_products / (matrix_norms * query_norm + 1e-8)
    return similarities


def search_ks(
    source_text: str, ks_data: dict
) -> tuple[str, float]:
    """Search KS embeddings for best match.
    
    Returns: (translated_text, similarity)
    """
    query_emb = compute_embedding(source_text)
    if query_emb is None:
        return "", 0.0

    query_vec = np.array(query_emb, dtype=np.float32)
    similarities = cosine_similarity(query_vec, ks_data["embeddings"])

    best_idx = int(np.argmax(similarities))
    best_sim = float(similarities[best_idx])
    best_text = ks_data["texts"][best_idx]

    return best_text, best_sim


def parse_translate_block(block_content: str) -> dict:
    """Parse a translate block's content to extract info.
    
    Returns dict with:
      - source_comment: the English source comment line (full line with indent)
      - source_text: the English text inside quotes
      - has_translation: whether a translation already exists
      - indent: the indentation used in the block
    """
    lines = block_content.split("\n")
    source_comment = None
    source_text = None
    has_translation = False
    indent = "    "

    for line in lines:
        stripped = line.strip()
        if not stripped:
            continue

        # Check for source comment: # "English" or # speaker "English"
        m = SOURCE_COMMENT_PATTERN.match(line)
        if m and "[旧版翻译]" not in line and "[机翻]" not in line:
            source_comment = line
            source_text = m.group(3)
            indent = line[: len(line) - len(line.lstrip())]
            continue

        # Check for existing translation markers
        if "[旧版翻译]" in line or "[机翻]" in line:
            has_translation = True
            continue

        # Check for translation line: speaker "中文" or "" "中文"
        if stripped and not stripped.startswith("#") and '"' in stripped:
            # Check if it's a non-empty translation
            trans_m = re.match(r'^\s*(\w+)\s+"(.*)"$', line)
            if trans_m:
                trans_text = trans_m.group(2)
                if trans_text:
                    has_translation = True

    return {
        "source_comment": source_comment,
        "source_text": source_text,
        "has_translation": has_translation,
        "indent": indent,
    }


def build_new_block_content(
    original_content: str,
    translation: str,
    similarity: float,
    is_old: bool = True,
) -> str:
    """Build new block content with translation inserted.
    
    Strategy:
    - Find the source comment line
    - Insert translation lines after it
    - Replace any existing empty translation line
    """
    lines = original_content.split("\n")
    new_lines = []
    inserted = False
    marker = "# [旧版翻译]" if is_old else "# [机翻]"

    for i, line in enumerate(lines):
        new_lines.append(line)

        # Insert after source comment (but skip marker lines)
        if not inserted and SOURCE_COMMENT_PATTERN.match(line):
            if "[旧版翻译]" not in line and "[机翻]" not in line:
                indent = line[: len(line) - len(line.lstrip())]
                new_lines.append(f'{indent}{marker} 相似度: {similarity:.2f}')
                new_lines.append(f'{indent}"" "{translation}"')
                inserted = True

    # If we didn't insert (no source comment found), append at end
    if not inserted and translation:
        indent = "    "
        for line in lines:
            if line.strip():
                indent = line[: len(line) - len(line.lstrip())]
                break
        new_lines.append(f"{indent}{marker} 相似度: {similarity:.2f}")
        new_lines.append(f'{indent}"" "{translation}"')

    return "\n".join(new_lines)


def process_rpy_file(
    rpy_path: Path,
    mapping: dict,
    threshold: float,
    dry_run: bool = False,
    limit: Optional[int] = None,
) -> dict:
    """Process a single RPY file.
    
    Returns stats dict.
    """
    rpy_name = rpy_path.name
    rpy_mapping = mapping.get(rpy_name, {})

    if not rpy_mapping:
        log.info("  [SKIP] No mapping entries for %s", rpy_name)
        return {"skipped_no_mapping": 1}

    with open(rpy_path, encoding="utf-8") as f:
        content = f.read()

    stats = {
        "total": 0,
        "already_translated": 0,
        "matched": 0,
        "skipped_new": 0,
        "skipped_low_sim": 0,
        "skipped_no_ks": 0,
        "errors": 0,
    }

    # Collect all blocks first
    all_matches = list(TRANSLATE_BLOCK_PATTERN.finditer(content))
    log.info("  Found %d translate blocks in %s", len(all_matches), rpy_name)

    # Apply limit
    if limit is not None:
        all_matches = all_matches[:limit]
        log.info("  Limited to first %d blocks", limit)

    processed_count = 0
    start_time = time.time()

    replacements = []

    for match in all_matches:
        prefix, block_id, colon, block_content = match.groups()
        label_prefix = block_id.rsplit("_", 1)[0]

        # Check mapping
        prefix_info = rpy_mapping.get(label_prefix)
        if not prefix_info:
            # Try shorter prefix
            for map_prefix, info in rpy_mapping.items():
                if label_prefix.startswith(map_prefix):
                    prefix_info = info
                    break

        if not prefix_info:
            stats["skipped_no_mapping"] = stats.get("skipped_no_mapping", 0) + 1
            continue

        ks_file = prefix_info.get("ks_file", "")
        status = prefix_info.get("status", "new")
        stats["total"] += 1

        # Parse existing block
        parsed = parse_translate_block(block_content)

        if parsed["has_translation"]:
            stats["already_translated"] += 1
            continue

        if not parsed["source_text"]:
            stats["errors"] += 1
            log.debug("    [ERROR] No source text in block %s", block_id)
            continue

        # New content - skip
        if status == "new":
            stats["skipped_new"] += 1
            if processed_count < 3:
                log.debug("    [NEW] %s (skipping, new content)", block_id)
            continue

        # No KS file
        if not ks_file:
            stats["skipped_no_ks"] += 1
            continue

        # Load KS data
        ks_data = get_ks_data(ks_file)
        if ks_data is None:
            stats["skipped_no_ks"] += 1
            log.warning("    [WARN] Cannot load KS data for %s", ks_file)
            continue

        # Search
        translation, similarity = search_ks(parsed["source_text"], ks_data)
        processed_count += 1

        if similarity >= threshold:
            new_content = build_new_block_content(
                block_content, translation, similarity, is_old=True
            )
            stats["matched"] += 1
            log.info(
                "    [MATCH] %s -> %s (sim=%.2f) \"%s...\"",
                block_id,
                ks_file,
                similarity,
                translation[:30],
            )
            replacements.append((match.start(), match.end(), prefix + block_id + colon + new_content))
        else:
            stats["skipped_low_sim"] += 1
            if processed_count <= 3:
                log.debug(
                    "    [LOW] %s sim=%.2f < %.2f", block_id, similarity, threshold
                )

    # Apply replacements in reverse order to preserve positions
    if replacements and not dry_run:
        new_content = content
        for start, end, replacement in reversed(replacements):
            new_content = new_content[:start] + replacement + new_content[end:]
        with open(rpy_path, "w", encoding="utf-8") as f:
            f.write(new_content)
        log.info("  [WRITE] %s: %d translations inserted", rpy_name, len(replacements))
    elif replacements and dry_run:
        log.info("  [DRY-RUN] %s: %d translations would be inserted", rpy_name, len(replacements))

    elapsed = time.time() - start_time
    stats["elapsed"] = elapsed
    return stats


def main():
    parser = argparse.ArgumentParser(description="Auto-translate RPY files using KS embeddings")
    parser.add_argument(
        "--mapping", default=str(MAPPING_FILE), help="Path to mapping JSON"
    )
    parser.add_argument(
        "--rpy-source", default=str(RPY_SOURCE), help="RPY source directory"
    )
    parser.add_argument(
        "--threshold", type=float, default=0.8, help="Similarity threshold (default: 0.8)"
    )
    parser.add_argument(
        "--dry-run", action="store_true", help="Don't modify files, just show what would change"
    )
    parser.add_argument(
        "--limit", type=int, default=None, help="Limit number of blocks to process per file"
    )
    parser.add_argument(
        "--file", type=str, default=None, help="Process only this specific RPY file"
    )
    parser.add_argument(
        "--debug", action="store_true", help="Enable debug logging"
    )

    args = parser.parse_args()

    if args.debug:
        logging.getLogger().setLevel(logging.DEBUG)

    log.info("=" * 60)
    log.info("Auto-translate starting")
    log.info("Threshold: %.2f | Dry run: %s", args.threshold, args.dry_run)
    log.info("=" * 60)

    # Load mapping
    mapping_path = Path(args.mapping)
    with open(mapping_path, encoding="utf-8") as f:
        mapping = json.load(f)
    total = sum(len(v) for v in mapping.values())
    log.info("Mapping loaded: %d RPY files, %d label prefixes", len(mapping), total)

    # Determine files to process
    rpy_source = Path(args.rpy_source)
    if args.file:
        files = [rpy_source / args.file]
        if not files[0].exists():
            log.error("File not found: %s", files[0])
            return
    else:
        files = sorted(rpy_source.glob("*.rpy"))
        # Filter to only files that have mapping entries
        files = [f for f in files if f.name in mapping]

    log.info("Files to process: %d", len(files))
    if not files:
        log.warning("No files to process! Check --rpy-source and mapping.")
        return

    total_stats = {
        "total": 0,
        "already_translated": 0,
        "matched": 0,
        "skipped_new": 0,
        "skipped_low_sim": 0,
        "skipped_no_ks": 0,
        "skipped_no_mapping": 0,
        "errors": 0,
        "elapsed": 0,
    }

    for i, rpy_file in enumerate(files):
        log.info("-" * 40)
        log.info("[%d/%d] Processing %s", i + 1, len(files), rpy_file.name)

        stats = process_rpy_file(
            rpy_file, mapping, args.threshold, args.dry_run, args.limit
        )

        for key in total_stats:
            if key != "elapsed":
                total_stats[key] += stats.get(key, 0)
        total_stats["elapsed"] += stats.get("elapsed", 0)

        log.info(
            "  Total: %d | Matched: %d | Existing: %d | New: %d | Low sim: %d | No KS: %d",
            stats.get("total", 0),
            stats.get("matched", 0),
            stats.get("already_translated", 0),
            stats.get("skipped_new", 0),
            stats.get("skipped_low_sim", 0),
            stats.get("skipped_no_ks", 0),
        )

    log.info("=" * 60)
    log.info("Final Summary")
    log.info("=" * 60)
    log.info("Files processed: %d", len(files))
    log.info("Total blocks: %d", total_stats["total"])
    log.info("Already translated: %d", total_stats["already_translated"])
    log.info("Matched & written: %d", total_stats["matched"])
    log.info("Skipped (new content): %d", total_stats["skipped_new"])
    log.info("Skipped (low similarity): %d", total_stats["skipped_low_sim"])
    log.info("Skipped (no KS data): %d", total_stats["skipped_no_ks"])
    log.info("Errors: %d", total_stats["errors"])
    log.info("Total time: %.1fs", total_stats["elapsed"])

    if total_stats["total"] > 0:
        success_rate = total_stats["matched"] / total_stats["total"] * 100
        log.info("Success rate: %.1f%%", success_rate)


if __name__ == "__main__":
    main()
