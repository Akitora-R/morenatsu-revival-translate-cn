#!/usr/bin/env python3
"""
Manage RPY translation blocks in a JSONL table.

Workflow:
  1. init    — Extract all blocks from RPY files into a JSONL table
  2. update  — Update specific block(s) with translation info
  3. apply   — Write translations from JSONL back into RPY files
  4. status  — Show translation progress summary

JSONL entry format:
  {
    "id": "torahiko03_57e52401",
    "rpy_file": "day 3.rpy",
    "source_line": 99,
    "speaker": "gm",
    "source": "「Hello. This is [ln] speaking.{w} Oh, yes!{p}Please wait a minute.」",
    "translation": "「你好，这里是[西村]家。哎呀，你好啊！……嗯，稍等一下哦……",
    "translation_type": "旧版翻译",
    "translation_source": "3日目.ks",
    "ks_lines": "18-19",
    "embedding": null
  }

Field descriptions:
  id                 — translate block ID (unique key)
  rpy_file           — source RPY filename
  source_line        — line number in original game script
  speaker            — speaker prefix (fn/gm/ka etc.) or "" for narration
  source             — English source text from # comment
  translation        — Chinese translation text, "" if not translated
  translation_type   — "旧版翻译" | "机翻" | "人工" | ""
  translation_source — origin file/model (e.g. "3日目.ks", "gpt-4o")
  ks_lines           — KS source line range (e.g. "18-19")
  embedding          — vector embedding of source text, null until computed

translation_type values:
  "旧版翻译"  — matched from original KS Chinese translation
  "机翻"      — LLM machine translation
  "人工"      — human translation
  ""          — not yet translated

Usage:
  # Initialize / re-extract from RPY files
  python scripts/translate.py init

  # Check progress
  python scripts/translate.py status

  # Export untranslated blocks for LLM prompt
  python scripts/translate.py export-untranslated --file "day 3.rpy"
  python scripts/translate.py export-untranslated --prefix torahiko03

  # Update single block
  python scripts/translate.py update \\
      --block-id torahiko03_57e52401 \\
      --translation "你好" --type "旧版翻译" \\
      --source "3日目.ks" --ks-lines "18-19"

  # Batch update from JSONL (one JSON object per line)
  #   Each line: {"id":"xxx","translation":"xxx","translation_type":"机翻","translation_source":"gpt-4o"}
  python scripts/translate.py update --batch updates.jsonl

  # Batch update from JSON file (single object or list)
  python scripts/translate.py update --input update.json

  # Apply translations back to RPY files
  python scripts/translate.py apply --dry-run              # all files
  python scripts/translate.py apply --file "day 3.rpy"     # single file
  python scripts/translate.py apply --start-day 3          # from day 3 onwards

  # Compute embeddings for source texts (requires Ollama running)
  python scripts/translate.py embed --model paraphrase-multilingual:278m
  python scripts/translate.py embed --model paraphrase-multilingual:278m --file "day 3.rpy"
  python scripts/translate.py embed --model paraphrase-multilingual:278m --force  # overwrite existing
"""

import re
import json
import sys
import argparse
import subprocess
from pathlib import Path
from copy import deepcopy
from typing import Optional

RPY_DIR = Path("rpy")
TABLE_FILE = Path("translation_table.jsonl")

TRANSLATE_BLOCK_RE = re.compile(
    r"(translate\s+chinese_simplified\s+)(\w+)(:\s*\n)((?:[ \t]+[^\n]*\n)*)",
    re.MULTILINE,
)
SOURCE_COMMENT_RE = re.compile(r'^\s*#\s+(?:(\w+)\s+)?"(.*)"$')
RPY_SOURCE_LINE_RE = re.compile(r"# game/.*?:(\d+)")


def extract_rpy_blocks(rpy_path: Path) -> list[dict]:
    """Extract all translate blocks from a single RPY file."""
    with open(rpy_path, encoding="utf-8") as f:
        content = f.read()

    results = []
    for match in TRANSLATE_BLOCK_RE.finditer(content):
        block_id = match.group(2)
        if block_id == "strings":
            continue
        block_content = match.group(4)

        source_line = 0
        preceding = content[:match.start()]
        for line in reversed(preceding.rsplit("\n", 5)):
            m = RPY_SOURCE_LINE_RE.search(line)
            if m:
                source_line = int(m.group(1))
                break

        source_text = None
        speaker = None
        translation = ""
        translation_type = ""
        translation_source = ""
        ks_lines = ""

        lines = block_content.split("\n")
        for line in lines:
            stripped = line.strip()
            if not stripped:
                continue

            # Source comment
            m = SOURCE_COMMENT_RE.match(line)
            if m and "[旧版翻译]" not in line and "[机翻]" not in line:
                speaker = m.group(1) or ""
                source_text = m.group(2)
                continue

            # [旧版翻译] marker
            if "[旧版翻译]" in line:
                translation_type = "旧版翻译"
                marker_m = re.search(r"来源:\s*(\S+?)(?:\s|$)", line)
                if marker_m:
                    translation_source = marker_m.group(1)
                ks_m = re.search(r"\(KS\s+([\d\-]+)\)", line)
                if ks_m:
                    ks_lines = ks_m.group(1)
                continue

            # [机翻] marker
            if "[机翻]" in line:
                translation_type = "机翻"
                continue

            # Translation line
            if not stripped.startswith("#") and '"' in stripped:
                trans_m = re.match(r'^\s*(\w*)\s+"(.*)"$', line)
                if trans_m:
                    if not speaker:
                        speaker = trans_m.group(1)
                    text = trans_m.group(2)
                    if text:
                        translation = text
                        if not translation_type:
                            translation_type = "旧版翻译"

        results.append({
            "id": block_id,
            "rpy_file": rpy_path.name,
            "source_line": source_line,
            "speaker": speaker or "",
            "source": source_text or "",
            "translation": translation,
            "translation_type": translation_type,
            "translation_source": translation_source,
            "ks_lines": ks_lines,
            "embedding": None,
        })

    return results


def load_table(path: Path = TABLE_FILE) -> dict[str, dict]:
    """Load JSONL table into dict keyed by block id."""
    table = {}
    if not path.exists():
        return table
    with open(path, encoding="utf-8") as f:
        for line in f:
            entry = json.loads(line)
            table[entry["id"]] = entry
    return table


def save_table(table: dict[str, dict], path: Path = TABLE_FILE):
    """Save table dict to JSONL, sorted by rpy_file then source_line."""
    path.parent.mkdir(parents=True, exist_ok=True)
    entries = sorted(table.values(), key=lambda e: (e.get("rpy_file", ""), e.get("source_line", 0)))
    with open(path, "w", encoding="utf-8") as f:
        for entry in entries:
            f.write(json.dumps(entry, ensure_ascii=False) + "\n")


def cmd_init(args):
    """Initialize table from all RPY files."""
    rpy_dir = Path(args.rpy_dir)
    table = {}

    for rpy_file in sorted(rpy_dir.glob("*.rpy")):
        blocks = extract_rpy_blocks(rpy_file)
        for block in blocks:
            table[block["id"]] = block
        print(f"  {rpy_file.name}: {len(blocks)} blocks")

    save_table(table)
    total = len(table)
    translated = sum(1 for e in table.values() if e.get("translation"))
    print(f"\nTotal: {total} blocks, {translated} translated, {total - translated} untranslated")


def cmd_update(args):
    """Update specific block(s) in the table."""
    table = load_table()

    if args.input:
        # Read updates from JSON file
        with open(args.input, encoding="utf-8") as f:
            updates = json.load(f)
        if isinstance(updates, dict):
            updates = [updates]
        for update in updates:
            block_id = update.get("id")
            if not block_id or block_id not in table:
                print(f"  [SKIP] Block not found: {block_id}")
                continue
            for key in ("translation", "translation_type", "translation_source", "ks_lines", "embedding"):
                if key in update:
                    table[block_id][key] = update[key]
            print(f"  [UPDATE] {block_id}")

    elif args.block_id:
        # Update single block from CLI args
        if args.block_id not in table:
            print(f"Block not found: {args.block_id}")
            return
        entry = table[args.block_id]
        if args.translation is not None:
            entry["translation"] = args.translation
        if args.type is not None:
            entry["translation_type"] = args.type
        if args.source is not None:
            entry["translation_source"] = args.source
        if args.ks_lines is not None:
            entry["ks_lines"] = args.ks_lines
        if args.embedding is not None:
            entry["embedding"] = json.loads(args.embedding)
        print(f"  [UPDATE] {args.block_id}")

    elif args.batch:
        # Batch update from JSONL: each line has id + fields to update
        count = 0
        with open(args.batch, encoding="utf-8") as f:
            for line in f:
                update = json.loads(line)
                block_id = update.get("id")
                if not block_id or block_id not in table:
                    continue
                for key in ("translation", "translation_type", "translation_source", "ks_lines", "embedding"):
                    if key in update:
                        table[block_id][key] = update[key]
                count += 1
        print(f"  [BATCH] Updated {count} blocks")

    else:
        print("No update source specified. Use --input, --block-id, or --batch")
        return

    save_table(table)


def cmd_apply(args):
    """Apply translations from table back to RPY files."""
    table = load_table()
    rpy_dir = Path(args.rpy_dir)

    if args.file:
        files = [rpy_dir / args.file]
    elif args.start_day is not None:
        files = []
        for f in sorted(rpy_dir.glob("*.rpy")):
            m = re.search(r'[Dd]ay\s+(\d+)', f.name)
            if m and int(m.group(1)) >= args.start_day:
                files.append(f)
    else:
        files = sorted(rpy_dir.glob("*.rpy"))

    for rpy_file in files:
        with open(rpy_file, encoding="utf-8") as f:
            content = f.read()

        replacements = []
        for match in TRANSLATE_BLOCK_RE.finditer(content):
            block_id = match.group(2)
            if block_id == "strings":
                continue
            if block_id not in table:
                continue
            entry = table[block_id]
            translation = entry.get("translation", "")
            if not translation:
                continue

            block_content = match.group(4)
            new_content = _build_translated_block(block_content, entry)

            replacement = match.group(1) + block_id + match.group(3) + new_content
            replacements.append((match.start(), match.end(), replacement))

        if replacements and not args.dry_run:
            new_content = content
            for start, end, repl in reversed(replacements):
                new_content = new_content[:start] + repl + new_content[end:]
            with open(rpy_file, "w", encoding="utf-8") as f:
                f.write(new_content)
            print(f"  {rpy_file.name}: {len(replacements)} translations applied")
        elif replacements:
            print(f"  {rpy_file.name}: {len(replacements)} translations would be applied (dry-run)")


def _build_translated_block(block_content: str, entry: dict) -> str:
    """Build new block content with translation from table entry."""
    lines = block_content.split("\n")
    translation = entry.get("translation", "")
    ttype = entry.get("translation_type", "")
    tsource = entry.get("translation_source", "")
    ks_lines = entry.get("ks_lines", "")

    comment_indent = "    "
    trans_indent = "    "
    trans_speaker = ""

    result_lines = []
    for line in lines:
        stripped = line.strip()
        if not stripped:
            continue

        if "[旧版翻译]" in line or "[机翻]" in line:
            continue

        m = SOURCE_COMMENT_RE.match(line)
        if m:
            comment_indent = line[:len(line) - len(line.lstrip())]
            result_lines.append(line)
            continue

        trans_m = re.match(r'^\s*(\w*)\s+"(.*)"$', line)
        if trans_m and not stripped.startswith("#"):
            trans_indent = line[:len(line) - len(line.lstrip())]
            trans_speaker = trans_m.group(1)
            continue

        result_lines.append(line)

    # Build marker
    parts = [f"[{ttype}]"]
    if tsource:
        parts.append(f"来源: {tsource}")
    if ks_lines:
        parts.append(f"(KS {ks_lines})")
    if ttype:
        result_lines.append(f"{comment_indent}# " + " ".join(parts))

    # Build translation line
    if trans_speaker:
        result_lines.append(f'{trans_indent}{trans_speaker} "{translation}"')
    else:
        result_lines.append(f'{trans_indent}"{translation}"')

    return "\n".join(result_lines) + "\n"


def cmd_status(args):
    """Show translation status summary."""
    table = load_table()

    by_file = {}
    for entry in table.values():
        f = entry.get("rpy_file", "?")
        if f not in by_file:
            by_file[f] = {"total": 0, "translated": 0, "旧版翻译": 0, "机翻": 0, "人工": 0}
        by_file[f]["total"] += 1
        ttype = entry.get("translation_type", "")
        if entry.get("translation"):
            by_file[f]["translated"] += 1
            if ttype in by_file[f]:
                by_file[f][ttype] += 1

    total_all = 0
    translated_all = 0
    for fname in sorted(by_file):
        s = by_file[fname]
        pct = s["translated"] / s["total"] * 100 if s["total"] else 0
        print(f"  {fname:25s}  {s['translated']:4d}/{s['total']:4d} ({pct:5.1f}%)  旧版:{s['旧版翻译']} 机翻:{s['机翻']} 人工:{s['人工']}")
        total_all += s["total"]
        translated_all += s["translated"]

    pct = translated_all / total_all * 100 if total_all else 0
    print(f"\n  {'TOTAL':25s}  {translated_all:4d}/{total_all:4d} ({pct:5.1f}%)")


def cmd_export_ks(args):
    """Export blocks needing LLM translation as a prompt-friendly format."""
    table = load_table()

    blocks = []
    for entry in table.values():
        if not entry.get("translation") and entry.get("source"):
            blocks.append(entry)

    if args.file:
        rpy_name = args.file
        blocks = [e for e in blocks if e.get("rpy_file") == rpy_name]

    if args.prefix:
        blocks = [e for e in blocks if e["id"].startswith(args.prefix)]

    blocks.sort(key=lambda e: (e.get("rpy_file", ""), e.get("source_line", 0)))

    for entry in blocks:
        sp = entry.get("speaker", "")
        src = entry.get("source", "")
        prefix = f"{sp} " if sp else ""
        print(f"[{entry['id']}] {prefix}\"{src}\"")

    print(f"\n--- {len(blocks)} untranslated blocks ---", file=sys.stderr)


def _get_embeddings_batch(texts: list[str], model: str) -> list[Optional[list[float]]]:
    """Get embeddings for a batch of texts via Ollama."""
    results: list[Optional[list[float]]] = [None] * len(texts)
    non_empty = [(i, t) for i, t in enumerate(texts) if t.strip()]
    if not non_empty:
        return results

    batch_texts = [t for _, t in non_empty]
    try:
        result = subprocess.run(
            ["curl", "-s", "http://localhost:11434/api/embed",
             "-d", json.dumps({"model": model, "input": batch_texts})],
            capture_output=True, text=True, timeout=120,
        )
        data = json.loads(result.stdout)
        for j, (orig_idx, _) in enumerate(non_empty):
            results[orig_idx] = data["embeddings"][j]
    except Exception as e:
        print(f"  [ERROR] Batch embedding failed: {e}", file=sys.stderr)
        return results
    return results


def cmd_embed(args):
    """Compute embeddings for source texts and store in table."""
    import numpy as np
    import subprocess

    table = load_table()
    entries = list(table.values())
    entries.sort(key=lambda e: (e.get("rpy_file", ""), e.get("source_line", 0)))

    if args.file:
        entries = [e for e in entries if e.get("rpy_file") == args.file]
    if args.prefix:
        entries = [e for e in entries if e["id"].startswith(args.prefix)]
    if not args.force:
        entries = [e for e in entries if e.get("embedding") is None]

    entries = [e for e in entries if e.get("source")]

    if not entries:
        print("No entries to embed")
        return

    print(f"Embedding {len(entries)} entries with {args.model}...")
    batch_size = args.batch_size
    done = 0

    for batch_start in range(0, len(entries), batch_size):
        batch_end = min(batch_start + batch_size, len(entries))
        batch = entries[batch_start:batch_end]
        texts = [e["source"] for e in batch]

        embs = _get_embeddings_batch(texts, args.model)
        for j, emb in enumerate(embs):
            if emb is not None:
                table[batch[j]["id"]]["embedding"] = emb
                done += 1

        print(f"  {batch_end}/{len(entries)} ({done} embedded)")

    save_table(table)
    print(f"Done: {done}/{len(entries)} embeddings stored")


def main():
    parser = argparse.ArgumentParser(description="Manage RPY translation blocks")
    sub = parser.add_subparsers(dest="command", required=True)

    # init
    p_init = sub.add_parser("init", help="Initialize table from RPY files")
    p_init.add_argument("--rpy-dir", default=str(RPY_DIR))

    # update
    p_update = sub.add_parser("update", help="Update block(s) in table")
    p_update.add_argument("--input", help="JSON file with update(s)")
    p_update.add_argument("--batch", help="JSONL file with batch updates")
    p_update.add_argument("--block-id", help="Single block ID to update")
    p_update.add_argument("--translation", help="Translation text")
    p_update.add_argument("--type", help="Translation type (旧版翻译/机翻/人工)")
    p_update.add_argument("--source", help="Translation source file")
    p_update.add_argument("--ks-lines", help="KS source line range")
    p_update.add_argument("--embedding", help="Embedding vector as JSON array")

    # apply
    p_apply = sub.add_parser("apply", help="Apply translations to RPY files")
    p_apply.add_argument("--rpy-dir", default=str(RPY_DIR))
    p_apply.add_argument("--file", help="Apply to specific file only")
    p_apply.add_argument("--start-day", type=int, help="Apply from this day onwards")
    p_apply.add_argument("--dry-run", action="store_true")

    # status
    p_status = sub.add_parser("status", help="Show translation status")

    # export-ks
    p_export = sub.add_parser("export-untranslated", help="Export untranslated blocks")
    p_export.add_argument("--file", help="Filter by RPY file name")
    p_export.add_argument("--prefix", help="Filter by block ID prefix")

    # embed
    p_embed = sub.add_parser("embed", help="Compute source text embeddings")
    p_embed.add_argument("--model", default="paraphrase-multilingual:278m", help="Ollama embedding model")
    p_embed.add_argument("--file", help="Only embed entries from this RPY file")
    p_embed.add_argument("--prefix", help="Only embed entries with this ID prefix")
    p_embed.add_argument("--batch-size", type=int, default=50, help="Embedding batch size")
    p_embed.add_argument("--force", action="store_true", help="Re-embed even if embedding exists")

    args = parser.parse_args()

    if args.command == "init":
        cmd_init(args)
    elif args.command == "update":
        cmd_update(args)
    elif args.command == "apply":
        cmd_apply(args)
    elif args.command == "status":
        cmd_status(args)
    elif args.command == "export-untranslated":
        cmd_export_ks(args)
    elif args.command == "embed":
        cmd_embed(args)


if __name__ == "__main__":
    main()
