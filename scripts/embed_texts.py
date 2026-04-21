#!/usr/bin/env python3
"""
Generate embeddings for extracted texts using Ollama or OpenAI-compatible API.
Reads from output/texts/ and writes embeddings organized by date-route.

Usage:
    source .venv/bin/activate
    python scripts/embed_texts.py                          # all texts, ollama default
    python scripts/embed_texts.py --type untranslated       # only untranslated
    python scripts/embed_texts.py --batch-size 100          # larger batches
"""

import json
import sys
import time
import argparse
from pathlib import Path
from typing import Optional

try:
    import numpy as np
    from openai import OpenAI
except ImportError:
    print(
        "Error: Run `source .venv/bin/activate && uv pip install openai numpy` first."
    )
    sys.exit(1)

# Force unbuffered output
print = lambda *args, **kwargs: __builtins__.print(*args, **{**kwargs, "flush": True})


def get_client(mode: str, base_url: str, api_key: str, model: str):
    """Get OpenAI-compatible client."""
    if mode == "ollama":
        return OpenAI(base_url=base_url, api_key=api_key), model
    else:
        return OpenAI(base_url=base_url, api_key=api_key), model


def embed_text(
    client: OpenAI, model: str, text: str, dimensions: int = None, retries: int = 3
) -> Optional[list[float]]:
    """Embed a single text with retry logic."""
    for attempt in range(retries):
        try:
            kwargs = {"input": [text], "model": model}
            if dimensions:
                kwargs["dimensions"] = dimensions
            resp = client.embeddings.create(**kwargs)
            return resp.data[0].embedding
        except Exception as e:
            if attempt < retries - 1:
                wait = 2**attempt
                print(f"  Retry {attempt + 1}/{retries} after error: {e}")
                time.sleep(wait)
            else:
                print(f"  Failed after {retries} retries: {e}")
                return None


def load_jsonl(filepath: Path) -> list[dict]:
    """Load a JSONL file."""
    entries = []
    with open(filepath, "r", encoding="utf-8") as f:
        for line in f:
            line = line.strip()
            if line:
                entries.append(json.loads(line))
    return entries


def save_jsonl(filepath: Path, entries: list[dict]):
    """Save entries as JSONL."""
    filepath.parent.mkdir(parents=True, exist_ok=True)
    with open(filepath, "w", encoding="utf-8") as f:
        for e in entries:
            f.write(json.dumps(e, ensure_ascii=False) + "\n")


def process_translated(
    client: OpenAI,
    model: str,
    texts_dir: Path,
    output_dir: Path,
    batch_size: int = 50,
    dimensions: int = None,
):
    """Embed translated texts."""
    translated_dir = texts_dir / "translated"
    if not translated_dir.exists():
        print("No translated texts found.")
        return

    out_dir = output_dir / "translated"
    out_dir.mkdir(parents=True, exist_ok=True)

    for jsonl_file in sorted(translated_dir.glob("*.jsonl")):
        route = jsonl_file.stem
        print(f"Embedding translated: {route}")
        entries = load_jsonl(jsonl_file)

        out_file = out_dir / f"{route}.jsonl"

        # Build set of already-embedded IDs from output file
        done_ids = set()
        if out_file.exists():
            for e in load_jsonl(out_file):
                if "embedding" in e:
                    done_ids.add(e.get("id", ""))

        new_entries = [e for e in entries if e.get("id", "") not in done_ids]
        print(
            f"  {len(new_entries)} new entries to embed (out of {len(entries)} total)"
        )

        for i in range(0, len(new_entries), batch_size):
            batch = new_entries[i : i + batch_size]
            texts = []
            for e in batch:
                text_parts = []
                if e.get("source"):
                    text_parts.append(e["source"])
                if e.get("translated"):
                    text_parts.append(e["translated"])
                texts.append(" ".join(text_parts))

            try:
                kwargs = {"input": texts, "model": model}
                if dimensions:
                    kwargs["dimensions"] = dimensions
                resp = client.embeddings.create(**kwargs)
                for j, entry in enumerate(batch):
                    entry["embedding"] = resp.data[j].embedding
            except Exception as e:
                print(f"  Batch error: {e}, falling back to individual")
                for entry in batch:
                    text_parts = []
                    if entry.get("source"):
                        text_parts.append(entry["source"])
                    if entry.get("translated"):
                        text_parts.append(entry["translated"])
                    text = " ".join(text_parts)
                    emb = embed_text(client, model, text, dimensions=dimensions)
                    if emb:
                        entry["embedding"] = emb

            # Append batch to output file
            with open(out_file, "a", encoding="utf-8") as f:
                for entry in batch:
                    f.write(json.dumps(entry, ensure_ascii=False) + "\n")
            print(
                f"  Processed {min(i + batch_size, len(new_entries))}/{len(new_entries)}"
            )


def process_untranslated(
    client: OpenAI,
    model: str,
    texts_dir: Path,
    output_dir: Path,
    batch_size: int = 50,
    dimensions: int = None,
):
    """Embed untranslated texts."""
    untranslated_dir = texts_dir / "untranslated"
    if not untranslated_dir.exists():
        print("No untranslated texts found.")
        return

    out_dir = output_dir / "untranslated"
    out_dir.mkdir(parents=True, exist_ok=True)

    for jsonl_file in sorted(untranslated_dir.glob("*.jsonl")):
        route = jsonl_file.stem
        print(f"Embedding untranslated: {route}")
        entries = load_jsonl(jsonl_file)

        out_file = out_dir / f"{route}.jsonl"

        # Build set of already-embedded IDs from output file
        done_ids = set()
        if out_file.exists():
            for e in load_jsonl(out_file):
                if "embedding" in e:
                    done_ids.add(e.get("id", ""))

        new_entries = [e for e in entries if e.get("id", "") not in done_ids]
        print(
            f"  {len(new_entries)} new entries to embed (out of {len(entries)} total)"
        )

        for i in range(0, len(new_entries), batch_size):
            batch = new_entries[i : i + batch_size]
            texts = [e.get("source", "") for e in batch]

            try:
                kwargs = {"input": texts, "model": model}
                if dimensions:
                    kwargs["dimensions"] = dimensions
                resp = client.embeddings.create(**kwargs)
                for j, entry in enumerate(batch):
                    entry["embedding"] = resp.data[j].embedding
            except Exception as e:
                print(f"  Batch error: {e}, falling back to individual")
                for entry in batch:
                    emb = embed_text(
                        client, model, entry.get("source", ""), dimensions=dimensions
                    )
                    if emb:
                        entry["embedding"] = emb

            # Append batch to output file
            with open(out_file, "a", encoding="utf-8") as f:
                for entry in batch:
                    f.write(json.dumps(entry, ensure_ascii=False) + "\n")
            print(
                f"  Processed {min(i + batch_size, len(new_entries))}/{len(new_entries)}"
            )


def process_ks_texts(
    client: OpenAI,
    model: str,
    texts_dir: Path,
    output_dir: Path,
    batch_size: int = 50,
    dimensions: int = None,
):
    """Embed KS texts."""
    ks_dir = texts_dir / "ks_texts"
    if not ks_dir.exists():
        print("No KS texts found.")
        return

    out_dir = output_dir / "ks_texts"
    out_dir.mkdir(parents=True, exist_ok=True)

    for jsonl_file in sorted(ks_dir.glob("*.jsonl")):
        route = jsonl_file.stem
        print(f"Embedding KS texts: {route}")
        entries = load_jsonl(jsonl_file)

        out_file = out_dir / f"{route}.jsonl"

        # Build set of already-embedded text hashes from output file
        done_texts = set()
        if out_file.exists():
            for e in load_jsonl(out_file):
                if "embedding" in e:
                    done_texts.add(hash(e.get("text", "")))

        # Skip entries already embedded
        new_entries = [e for e in entries if hash(e.get("text", "")) not in done_texts]
        print(
            f"  {len(new_entries)} new entries to embed (out of {len(entries)} total)"
        )

        for i in range(0, len(new_entries), batch_size):
            batch = new_entries[i : i + batch_size]
            texts = [e.get("text", "") for e in batch]

            try:
                kwargs = {"input": texts, "model": model}
                if dimensions:
                    kwargs["dimensions"] = dimensions
                resp = client.embeddings.create(**kwargs)
                for j, entry in enumerate(batch):
                    entry["embedding"] = resp.data[j].embedding
            except Exception as e:
                print(f"  Batch error: {e}, falling back to individual")
                for entry in batch:
                    emb = embed_text(
                        client, model, entry.get("text", ""), dimensions=dimensions
                    )
                    if emb:
                        entry["embedding"] = emb

            # Append batch to output file
            with open(out_file, "a", encoding="utf-8") as f:
                for entry in batch:
                    f.write(json.dumps(entry, ensure_ascii=False) + "\n")
            print(
                f"  Processed {min(i + batch_size, len(new_entries))}/{len(new_entries)}"
            )


def main():
    parser = argparse.ArgumentParser(
        description="Generate embeddings for extracted texts"
    )
    parser.add_argument(
        "--mode",
        choices=["ollama", "openai"],
        default="ollama",
        help="Embedding provider",
    )
    parser.add_argument(
        "--base-url",
        default="http://localhost:11434/v1",
        help="API base URL (default: http://localhost:11434/v1 for Ollama)",
    )
    parser.add_argument(
        "--api-key", default="ollama", help="API key (default: 'ollama' for Ollama)"
    )
    parser.add_argument(
        "--model", default="qwen3-embedding:4b", help="Embedding model name"
    )
    parser.add_argument(
        "--dimensions",
        type=int,
        default=None,
        help="Output embedding dimensions (default: model native)",
    )
    parser.add_argument(
        "--texts-dir", default="output/texts", help="Directory with extracted texts"
    )
    parser.add_argument(
        "--output", default="output/embeddings", help="Output directory for embeddings"
    )
    parser.add_argument(
        "--batch-size", type=int, default=50, help="Batch size for API calls"
    )
    parser.add_argument(
        "--type",
        choices=["translated", "untranslated", "ks", "all"],
        default="all",
        help="Which texts to embed",
    )

    args = parser.parse_args()

    client, model = get_client(args.mode, args.base_url, args.api_key, args.model)
    texts_dir = Path(args.texts_dir)
    output_dir = Path(args.output)

    if not texts_dir.exists():
        print(f"Error: {texts_dir} not found. Run extract_texts.py first.")
        sys.exit(1)

    if args.type in ("translated", "all"):
        print("=" * 60)
        print("Embedding translated texts...")
        print("=" * 60)
        process_translated(
            client, model, texts_dir, output_dir, args.batch_size, args.dimensions
        )

    if args.type in ("untranslated", "all"):
        print("\n" + "=" * 60)
        print("Embedding untranslated texts...")
        print("=" * 60)
        process_untranslated(
            client, model, texts_dir, output_dir, args.batch_size, args.dimensions
        )

    if args.type in ("ks", "all"):
        print("\n" + "=" * 60)
        print("Embedding KS texts...")
        print("=" * 60)
        process_ks_texts(
            client, model, texts_dir, output_dir, args.batch_size, args.dimensions
        )

    print("\nDone!")


if __name__ == "__main__":
    main()
