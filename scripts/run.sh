#!/bin/bash
# Convenience script to run extraction and embedding pipeline
# Usage: ./scripts/run.sh [extract|embed|both]
set -e

ACTION="${1:-both}"

# Activate venv
source .venv/bin/activate

if [ "$ACTION" = "extract" ] || [ "$ACTION" = "both" ]; then
    echo "=== Step 1: Extracting texts ==="
    python scripts/extract_texts.py --mode both
fi

if [ "$ACTION" = "embed" ] || [ "$ACTION" = "both" ]; then
    echo ""
    echo "=== Step 2: Generating embeddings ==="
    python scripts/embed_texts.py --mode ollama --model qwen3-embedding:8b
fi
