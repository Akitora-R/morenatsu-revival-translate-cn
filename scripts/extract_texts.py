#!/usr/bin/env python3
"""
Extract texts from .rpy and .ks files for the Morenatsu translation project.
Output is organized by date-route structure in output/ directory.
"""

import re
import os
import json
import sys
from pathlib import Path
from typing import Optional


# Route name mapping
ROUTE_NAMES = {
    # 6 main characters
    "torahiko": "虎彦",
    "shin": "深",
    "kounosuke": "孝之助",
    "river": "洸哉",
    "kouya": "洸哉",
    "shun": "峻",
    "tatsuki": "辰樹",
    "juuichi": "柔一",
    # Day-specific common content
    "day": "共通",
    "common": "共通",
    # Special events
    "begin": "共通",
    "beach": "海滩事件",
    "camp": "露营事件",
    "sit_with": "选择路线",
    "nanafuse": "七缝",
    "river02": "洸哉",
    "candy": "共通",
    "map": "共通",
    "party_end": "欢迎会",
    "new_afterword": "结局",
    "strings": "界面",
    # System files
    "welcome": "欢迎会",
    "ending": "结局",
    "replay": "回放",
    "save": "存档",
    "nameinput": "命名",
    "initname": "命名初始化",
    "options": "选项",
    "screens": "界面",
}


def identify_route(block_id: str) -> str:
    """Identify route from translation block ID."""
    bid = block_id.lower()
    for key, name in ROUTE_NAMES.items():
        if key in bid:
            return name
    return "未知"


def identify_route_ks(filename: str) -> str:
    """Identify route from .ks filename."""
    name = Path(filename).stem
    # Character route patterns
    char_map = {
        "洸哉": "洸哉",
        "辰樹": "辰樹",
        "峻": "峻",
        "深": "深",
        "柔一": "柔一",
        "孝之助": "孝之助",
        "虎彦": "虎彦",
    }
    for char, route in char_map.items():
        if char in name:
            return route
    # Day files
    day_match = re.match(r"(\d+)日目", name)
    if day_match:
        return f"Day{day_match.group(1)}"
    return name


def extract_rpy(filepath: str) -> list[dict]:
    """
    Extract translation blocks from a .rpy file.
    Returns list of dicts with keys:
      - id: translation block ID
      - route: identified route
      - source: English source text (from comment)
      - speaker: speaker prefix (fn, ta, etc.) or None for narration
      - translated: Chinese text if translated, None if empty
      - is_old_translation: True if marked with [旧版翻译]
      - line_number: line number in file
    """
    results = []
    with open(filepath, "r", encoding="utf-8") as f:
        lines = f.readlines()

    i = 0
    while i < len(lines):
        line = lines[i].rstrip("\n")

        # Match translate block header
        m = re.match(r"^translate\s+\S+\s+(\S+):", line)
        if m:
            block_id = m.group(1)
            route = identify_route(block_id)
            line_num = i + 1

            source = None
            speaker = None
            translated = None
            is_old = False

            i += 1
            # Read block contents until next block or empty line pattern
            found_content = False
            while i < len(lines):
                inner = lines[i].rstrip("\n")

                # Skip leading empty lines
                if not found_content and inner.strip() == "":
                    i += 1
                    continue

                found_content = True

                # Check for source comment: # "English" or # speaker "English"
                src_m = re.match(r'^\s*#\s*(?:(\w+)\s+)?"(.*)"$', inner)
                if src_m and "[旧版翻译]" not in inner:
                    speaker = src_m.group(1)
                    source = src_m.group(2)
                    i += 1
                    continue

                # Check for [旧版翻译] marker
                if "[旧版翻译]" in inner:
                    is_old = True
                    i += 1
                    continue

                # Check for translated line: speaker "中文" or "中文"
                trans_m = re.match(r'^\s*(?:(\w+)\s+)?"(.*)"$', inner)
                if trans_m and not inner.strip().startswith("#"):
                    if speaker is None:
                        speaker = trans_m.group(1)
                    text = trans_m.group(2)
                    if text:  # Non-empty = translated
                        translated = text
                    i += 1
                    continue

                # Empty line or next block = end of this block
                if (
                    inner.strip() == ""
                    or inner.startswith("# game/")
                    or inner.startswith("translate ")
                ):
                    break

                i += 1

            results.append(
                {
                    "id": block_id,
                    "route": route,
                    "source": source,
                    "speaker": speaker,
                    "translated": translated,
                    "is_old_translation": is_old,
                    "line_number": line_num,
                }
            )
        else:
            i += 1

    return results


def extract_ks(filepath: str) -> list[dict]:
    """
    Extract dialogue and narration from a .ks file.
    Returns list of dicts with keys:
      - route: identified route from filename
      - speaker: character name or None for narration
      - text: the actual text content
      - line_number: line number in file
      - section: current section label
      - source_file: original KS filename (without path)
    """
    results = []
    with open(filepath, "r", encoding="utf-8") as f:
        lines = f.readlines()

    route = identify_route_ks(filepath)
    current_section = "start"
    source_file = Path(filepath).stem

    i = 0
    while i < len(lines):
        line = lines[i].rstrip("\n")
        line_num = i + 1

        # Skip comments and empty lines
        if line.strip().startswith(";") or line.strip() == "":
            i += 1
            continue

        # Section labels: *label|description
        sec_m = re.match(r"^\*(\w+)\|?(.*)?$", line)
        if sec_m:
            current_section = sec_m.group(1)
            i += 1
            continue

        # Skip command lines [...]
        if line.strip().startswith("["):
            i += 1
            continue

        # Character dialogue: 【name】
        char_m = re.match(r"^【(.+?)】$", line.strip())
        if char_m:
            speaker = char_m.group(1)
            # Next line(s) contain the dialogue in 「」
            text_parts = []
            i += 1
            while i < len(lines):
                dline = lines[i].rstrip("\n")
                # Check for 「text」
                dia_m = re.search(r"「(.*?)」", dline)
                if dia_m:
                    text_parts.append(dia_m.group(1))
                    # Check if line ends without closing bracket (multi-line)
                    if "」" in dline:
                        i += 1
                        break
                    i += 1
                    continue
                elif (
                    dline.strip() == ""
                    or dline.strip().startswith("[")
                    or dline.strip().startswith(";")
                ):
                    break
                else:
                    # Plain text continuation
                    if dline.strip():
                        text_parts.append(dline.strip())
                    i += 1
                    continue

            text = "".join(text_parts)
            # Clean up KS markup like [l], [wdt], etc.
            text = re.sub(r"\[l\]|\[wdt\]|\[wt\]|\[p\]|\[r\]", "", text)
            text = text.strip()

            if text:
                results.append(
                    {
                        "route": route,
                        "speaker": speaker,
                        "text": text,
                        "line_number": line_num,
                        "section": current_section,
                        "source_file": source_file,
                    }
                )
            continue

        # Narration: plain text (not commands, not brackets)
        # Accumulate consecutive narration lines (separated by [l] tags) into one entry
        if (
            line.strip()
            and not line.strip().startswith("[")
            and not line.strip().startswith(";")
        ):
            text_parts = [line.strip()]
            start_line = line_num
            i += 1

            # Collect consecutive plain text lines
            while i < len(lines):
                next_line = lines[i].rstrip("\n")
                stripped = next_line.strip()

                # Stop at commands, comments, empty lines, or dialogue
                if (
                    stripped == ""
                    or stripped.startswith("[")
                    or stripped.startswith(";")
                    or stripped.startswith("【")
                    or re.match(r"^\*\w+", stripped)
                ):
                    break

                text_parts.append(stripped)
                i += 1

            # Merge and clean up
            text = "".join(text_parts)
            text = re.sub(r"\[l\]|\[wdt\]|\[wt\]|\[p\]|\[r\]", "", text)
            text = text.strip()

            if text and len(text) > 2:
                results.append(
                    {
                        "route": route,
                        "speaker": None,
                        "text": text,
                        "line_number": start_line,
                        "section": current_section,
                        "source_file": source_file,
                    }
                )
            continue

        i += 1

    return results


def process_rpy_files(rpy_dir: str, output_dir: str):
    """Process all .rpy files and output organized results."""
    rpy_path = Path(rpy_dir)
    output_path = Path(output_dir)
    output_path.mkdir(parents=True, exist_ok=True)

    all_translated = []
    all_untranslated = []

    for rpy_file in sorted(rpy_path.glob("*.rpy")):
        print(f"Processing {rpy_file.name}...")
        blocks = extract_rpy(str(rpy_file))

        for block in blocks:
            entry = {
                "id": block["id"],
                "route": block["route"],
                "source": block["source"] or "",
                "speaker": block["speaker"] or "",
                "file": rpy_file.name,
                "line": block["line_number"],
            }

            if block["translated"]:
                entry["translated"] = block["translated"]
                entry["is_old_translation"] = block["is_old_translation"]
                all_translated.append(entry)
            elif block["source"]:
                all_untranslated.append(entry)

    # Write organized output
    # 1. By date-route structure
    route_groups_t = {}
    route_groups_u = {}

    for entry in all_translated:
        key = f"{entry['route']}"
        route_groups_t.setdefault(key, []).append(entry)

    for entry in all_untranslated:
        key = f"{entry['route']}"
        route_groups_u.setdefault(key, []).append(entry)

    # Write translated texts
    translated_dir = output_path / "translated"
    translated_dir.mkdir(exist_ok=True)
    for route, entries in sorted(route_groups_t.items()):
        out_file = translated_dir / f"{route}.jsonl"
        with open(out_file, "w", encoding="utf-8") as f:
            for e in entries:
                f.write(json.dumps(e, ensure_ascii=False) + "\n")
        print(f"  Translated: {route} -> {len(entries)} entries")

    # Write untranslated texts
    untranslated_dir = output_path / "untranslated"
    untranslated_dir.mkdir(exist_ok=True)
    for route, entries in sorted(route_groups_u.items()):
        out_file = untranslated_dir / f"{route}.jsonl"
        with open(out_file, "w", encoding="utf-8") as f:
            for e in entries:
                f.write(json.dumps(e, ensure_ascii=False) + "\n")
        print(f"  Untranslated: {route} -> {len(entries)} entries")

    # Write summary
    summary = {
        "total_translated": len(all_translated),
        "total_untranslated": len(all_untranslated),
        "routes_translated": {k: len(v) for k, v in route_groups_t.items()},
        "routes_untranslated": {k: len(v) for k, v in route_groups_u.items()},
    }
    with open(output_path / "summary.json", "w", encoding="utf-8") as f:
        json.dump(summary, f, ensure_ascii=False, indent=2)

    print(f"\nSummary:")
    print(f"  Total translated: {len(all_translated)}")
    print(f"  Total untranslated: {len(all_untranslated)}")

    return all_translated, all_untranslated


def process_ks_files(ks_dirs: list[str], output_dir: str):
    """Process all .ks files and output organized results.

    Output files use the original KS filename (without .ks extension)
    to maintain a clear 1:1 mapping between KS source and JSONL output.

    When multiple directories contain files with the same name,
    only the first directory's version is used (priority order).
    This avoids double-counting overlapping files between
    extract/orig/ and extract/torahiko/.
    """
    output_path = Path(output_dir)
    output_path.mkdir(parents=True, exist_ok=True)

    # Collect files, deduplicating by filename (first dir wins)
    seen_filenames: set[str] = set()
    files_to_process: list[Path] = []

    for ks_dir in ks_dirs:
        ks_path = Path(ks_dir)
        if not ks_path.exists():
            print(f"Warning: {ks_dir} does not exist, skipping.")
            continue

        for ks_file in sorted(ks_path.glob("**/*.ks")):
            fname = ks_file.name
            if fname not in seen_filenames:
                seen_filenames.add(fname)
                files_to_process.append(ks_file)

    ks_output = output_path / "ks_texts"
    ks_output.mkdir(exist_ok=True)

    for ks_file in files_to_process:
        print(f"Processing {ks_file.name} (from {ks_file.parent.name})...")
        entries = extract_ks(str(ks_file))

        # Use original KS filename (without .ks) as output name
        out_name = ks_file.stem  # e.g. "2日目" or "辰樹_m_01"
        out_file = ks_output / f"{out_name}.jsonl"
        with open(out_file, "w", encoding="utf-8") as f:
            for e in entries:
                f.write(json.dumps(e, ensure_ascii=False) + "\n")
        print(f"  {ks_file.name} -> {out_name}.jsonl ({len(entries)} entries)")

    total = sum(len(extract_ks(str(f))) for f in files_to_process)
    print(f"\nTotal KS texts extracted: {total}")


def main():
    import argparse

    parser = argparse.ArgumentParser(
        description="Extract texts from .rpy and .ks files"
    )
    parser.add_argument(
        "--rpy-dir", default="rpy", help="Directory containing .rpy files"
    )
    parser.add_argument(
        "--ks-dirs",
        nargs="*",
        default=["extract/torahiko", "extract/orig"],
        help="Directories containing .ks files (first dir takes priority for overlapping filenames)",
    )
    parser.add_argument("--output", default="output/texts", help="Output directory")
    parser.add_argument(
        "--mode", choices=["rpy", "ks", "both"], default="both", help="Extraction mode"
    )

    args = parser.parse_args()

    if args.mode in ("rpy", "both"):
        print("=" * 60)
        print("Extracting from .rpy files...")
        print("=" * 60)
        process_rpy_files(args.rpy_dir, args.output)

    if args.mode in ("ks", "both"):
        print("\n" + "=" * 60)
        print("Extracting from .ks files...")
        print("=" * 60)
        process_ks_files(args.ks_dirs, args.output)


if __name__ == "__main__":
    main()
