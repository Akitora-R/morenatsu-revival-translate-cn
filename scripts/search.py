#!/usr/bin/env python3
"""
Search for similar texts using pre-computed embeddings.
Loads embeddings, embeds query, returns top-k matches by cosine similarity.

Usage:
    source .venv/bin/activate
    python scripts/search.py "你想翻译的英文句子"
    python scripts/search.py "你想翻译的英文句子" --top 10
    python scripts/search.py "你想翻译的英文句子" --scope ks
    python scripts/search.py "你想翻译的英文句子" --scope translated
"""

import json
import sys
import time
import argparse
from pathlib import Path

try:
    import numpy as np
    from openai import OpenAI
except ImportError:
    print(
        "Error: Run `source .venv/bin/activate && uv pip install openai numpy` first."
    )
    sys.exit(1)

print = lambda *args, **kwargs: __builtins__.print(*args, **{**kwargs, "flush": True})

CACHE_DIR = Path("output/.cache")
EMBEDDINGS_DIR = Path("output/embeddings")


def get_client(base_url: str, api_key: str):
    return OpenAI(base_url=base_url, api_key=api_key)


def embed_query(
    client: OpenAI, model: str, text: str, dimensions: int = None
) -> np.ndarray:
    """Embed a single query text and return normalized vector."""
    kwargs = {"input": [text], "model": model}
    if dimensions:
        kwargs["dimensions"] = dimensions
    resp = client.embeddings.create(**kwargs)
    vec = np.array(resp.data[0].embedding, dtype=np.float32)
    norm = np.linalg.norm(vec)
    if norm > 0:
        vec /= norm
    return vec


def load_embeddings_for_scope(scope: str) -> tuple[np.ndarray, list[dict]]:
    """
    Load embeddings for a given scope.
    Returns (normalized_matrix, metadata_list).
    Uses cached .npz if available, otherwise loads from JSONL.
    """
    cache_file = CACHE_DIR / f"{scope}.npz"

    if cache_file.exists():
        data = np.load(cache_file)
        matrix = data["matrix"]
        meta_json = data["meta"].tolist()
        meta = [json.loads(m) for m in meta_json]
        return matrix, meta

    # Load from JSONL
    if scope == "ks":
        src_dir = EMBEDDINGS_DIR / "ks_texts"
    elif scope == "translated":
        src_dir = EMBEDDINGS_DIR / "translated"
    elif scope == "untranslated":
        src_dir = EMBEDDINGS_DIR / "untranslated"
    elif scope == "all":
        src_dir = EMBEDDINGS_DIR
    else:
        print(f"Unknown scope: {scope}")
        sys.exit(1)

    if not src_dir.exists():
        print(f"Error: {src_dir} not found. Run embed_texts.py first.")
        sys.exit(1)

    vectors = []
    metadata = []

    if scope == "all":
        jsonl_files = sorted(src_dir.rglob("*.jsonl"))
    else:
        jsonl_files = sorted(src_dir.glob("*.jsonl"))

    for jsonl_file in jsonl_files:
        with open(jsonl_file, "r", encoding="utf-8") as f:
            for line in f:
                line = line.strip()
                if not line:
                    continue
                entry = json.loads(line)
                if "embedding" not in entry:
                    continue
                vectors.append(entry["embedding"])
                meta_entry = {k: v for k, v in entry.items() if k != "embedding"}
                meta_entry["_source_file"] = jsonl_file.stem
                metadata.append(meta_entry)

    if not vectors:
        print(f"Error: No embeddings found for scope '{scope}'.")
        sys.exit(1)

    matrix = np.array(vectors, dtype=np.float32)

    # Normalize
    norms = np.linalg.norm(matrix, axis=1, keepdims=True)
    norms[norms == 0] = 1
    matrix /= norms

    # Cache
    CACHE_DIR.mkdir(parents=True, exist_ok=True)
    meta_json = [json.dumps(m, ensure_ascii=False) for m in metadata]
    np.savez_compressed(cache_file, matrix=matrix, meta=np.array(meta_json))

    return matrix, metadata


def search(
    query: str,
    top_k: int = 10,
    scope: str = "ks",
    model: str = "qwen3-embedding:4b",
    dimensions: int = 1024,
    base_url: str = "http://localhost:11434/v1",
    api_key: str = "ollama",
    min_score: float = 0.0,
):
    """Search for similar texts."""
    client = get_client(base_url, api_key)

    t0 = time.time()
    print(f"Loading embeddings for scope: {scope}...")
    matrix, metadata = load_embeddings_for_scope(scope)
    load_time = time.time() - t0
    print(
        f"  Loaded {len(metadata)} embeddings ({matrix.shape[1]}d) in {load_time:.2f}s"
    )

    t1 = time.time()
    query_vec = embed_query(client, model, query, dimensions)
    embed_time = time.time() - t1
    print(f"  Query embedded in {embed_time:.2f}s")

    t2 = time.time()
    # Cosine similarity = dot product (both normalized)
    scores = matrix @ query_vec
    top_indices = np.argsort(scores)[::-1][:top_k]
    search_time = time.time() - t2
    print(f"  Search completed in {search_time * 1000:.1f}ms")

    print(f"\n{'=' * 60}")
    print(f'Top {top_k} results for: "{query}"')
    print(f"{'=' * 60}")

    for rank, idx in enumerate(top_indices, 1):
        score = float(scores[idx])
        if score < min_score:
            break
        meta = metadata[idx]

        # Display text based on scope
        if "text" in meta:
            text = meta["text"]
        elif "translated" in meta and meta.get("translated"):
            text = meta["translated"]
        elif "source" in meta:
            text = meta["source"]
        else:
            text = "(no text)"

        speaker = meta.get("speaker", "")
        source_file = meta.get("_source_file", "")
        route = meta.get("route", "")

        print(f"\n#{rank} [score: {score:.4f}]")
        if speaker:
            print(f"  Speaker: {speaker}")
        if route:
            print(f"  Route: {route}")
        print(f"  Source: {source_file}")
        print(f"  Text: {text[:200]}")
        if len(text) > 200:
            print(f"  ...")

    print(f"\n{'=' * 60}")
    total_time = load_time + embed_time + search_time
    print(
        f"Total time: {total_time:.2f}s (load: {load_time:.2f}s, embed: {embed_time:.2f}s, search: {search_time * 1000:.1f}ms)"
    )


def main():
    parser = argparse.ArgumentParser(
        description="Search similar texts by embedding similarity"
    )
    parser.add_argument("query", help="Query text to search for")
    parser.add_argument("--top", type=int, default=10, help="Number of results")
    parser.add_argument(
        "--scope",
        choices=["ks", "translated", "untranslated", "all"],
        default="ks",
        help="Which embeddings to search",
    )
    parser.add_argument("--model", default="qwen3-embedding:4b", help="Embedding model")
    parser.add_argument(
        "--dimensions", type=int, default=1024, help="Embedding dimensions"
    )
    parser.add_argument("--base-url", default="http://localhost:11434/v1")
    parser.add_argument("--api-key", default="ollama")
    parser.add_argument(
        "--min-score", type=float, default=0.0, help="Minimum similarity score"
    )
    parser.add_argument(
        "--rebuild-cache",
        action="store_true",
        help="Rebuild numpy cache from JSONL files",
    )

    args = parser.parse_args()

    if args.rebuild_cache:
        cache_scope = args.scope if args.scope != "all" else "all"
        cache_file = CACHE_DIR / f"{cache_scope}.npz"
        if cache_file.exists():
            cache_file.unlink()
            print(f"Cache cleared for scope: {cache_scope}")

    search(
        query=args.query,
        top_k=args.top,
        scope=args.scope,
        model=args.model,
        dimensions=args.dimensions,
        base_url=args.base_url,
        api_key=args.api_key,
        min_score=args.min_score,
    )


if __name__ == "__main__":
    main()
