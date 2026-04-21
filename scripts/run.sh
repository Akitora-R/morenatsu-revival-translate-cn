#!/bin/bash
# Convenience script to run extraction pipeline
# Usage: ./scripts/run.sh [extract|rpy|ks|init]
set -e

source .venv/bin/activate

ACTION="${1:-init}"

case "$ACTION" in
    extract|rpy)
        echo "=== Extracting RPY texts ==="
        python scripts/extract_texts.py --mode rpy
        ;;
    ks)
        echo "=== Extracting KS texts ==="
        python scripts/extract_texts.py --mode ks
        ;;
    both)
        echo "=== Extracting all texts ==="
        python scripts/extract_texts.py --mode both
        ;;
    init)
        echo "=== Initializing translation table ==="
        python scripts/translate.py init
        ;;
    *)
        echo "Usage: $0 [extract|rpy|ks|both|init]"
        exit 1
        ;;
esac
