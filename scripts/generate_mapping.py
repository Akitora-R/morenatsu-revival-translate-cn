#!/usr/bin/env python3
"""
Generate structured RPY → KS mapping for programmatic use.

Output: output/texts/rpy_to_ks_mapping.json
Structure:
{
  "rpy_file": {
    "label_prefix": {
      "ks_file": "original_ks_filename_without_extension",
      "entry_count": 123,
      "status": "old" | "new",
      "rpy_file": "RPY filename",
      "label_prefix": "label prefix"
    }
  }
}
"""

import json
from pathlib import Path
from collections import defaultdict

print = lambda *args, **kwargs: __builtins__.print(*args, **{**kwargs, "flush": True})

TEXTS_DIR = Path("output/texts")
UNTRANSLATED_DIR = TEXTS_DIR / "untranslated"
OUTPUT_MAPPING = TEXTS_DIR / "rpy_to_ks_mapping.json"

# Label prefix → KS file mapping
# KS file names use ORIGINAL .ks filenames (without .ks extension)
LABEL_TO_KS_MAP = {
    # === Day 2 ===
    "juuichi02": "柔一_m_01",
    "kounosuke02": "孝之助_m_01",
    "river02": "洸哉_s_01",
    "shin02": "深_m_01",
    "tatsuki02": "辰樹_m_01",
    "torahiko02": "2日目",
    # === Day 3 ===
    "candy03": "深_s_01",
    "shun03": "峻_m_01",
    "torahiko03": "3日目",
    # === Day 4 ===
    "juuichi04": "柔一_m_02",
    "kounosuke04": "孝之助_m_02",
    "shun04": "峻_s_05",
    "tatsuki04": "辰樹_s_01",
    "shin04": "深_m_02",
    "torahiko04": "4日目",
    # === Day 5 ===
    "juuichi05": "柔一_m_03",
    "tatsuki05": "辰樹_s_06",
    "kouya05": "洸哉_s_02",
    "torahiko05": "5日目",
    # === Day 6 ===
    "kounosuke06": "孝之助_s_02",
    "tatsuki06": "辰樹_s_02",
    "torahiko06": "6日目",
    # === Day 7 (beach - c_海水浴.ks for shared routes, 7日目 for torahiko) ===
    "beach07_juuichi": "c_海水浴",
    "beach07_kounosuke": "c_海水浴",
    "beach07_kouya": "c_海水浴",
    "beach07_shin": "c_海水浴",
    "beach07_shun": "c_海水浴",
    "beach07_tatsuki": "c_海水浴",
    "beach07_torahiko": "7日目",
    "torahiko07": "7日目",
    # === Day 8 ===
    "kounosuke08": "孝之助_s_03",
    "kouya08": "洸哉_s_03",
    "tatsuki08": "辰樹_s_07",
    "torahiko08": "8日目",
    # === Day 9 ===
    "juuichi09": "柔一_m_04",
    "kouya09": "洸哉_s_04",
    "shin09": "深_m_03",
    "shun09": "峻_s_07",
    "tatsuki09": "辰樹_s_05",
    "torahiko09": "9日目",
    # === Day 10 ===
    "juuichi10": "柔一_m_045",
    "kounosuke10": "孝之助_m_03",
    "shun10": "峻_m_02",
    "tatsuki10": "辰樹_m_02",
    "torahiko10": "10日目",
    # === Day 11 ===
    "juuichi11": "柔一_s_01",
    "shin11": "深_s_02",
    "tatsuki11": "辰樹_s_03",
    "torahiko11": "11日目",
    # === Day 12 ===
    "juuichi12": "柔一_s_02",
    "kouya12": "洸哉_s_05",
    "tatsuki12": "辰樹_m_03",
    "torahiko12": "12日目",
    # === Day 13 ===
    "shun13": "峻_s_01",
    "tatsuki13": "辰樹_s_04",
    "torahiko13": "13日目",
    # === Day 14 (camp day 1) ===
    "day14": "キャンプ01",
    # === Day 15 (camp day 2) ===
    "camp15_juuichi": "キャンプ02",
    "camp15_kounosuke": "キャンプ02",
    "camp15_kouya": "キャンプ02",
    "camp15_shin": "キャンプ02",
    "camp15_shun": "キャンプ02",
    "camp15_tatsuki": "キャンプ02",
    "camp15_torahiko": "キャンプ02",
    # === Day 16 ===
    "tatsuki16": "辰樹_m_04",
    "kounosuke16": "孝之助_m_04",
    "shun16": "峻_m_03",
    "kouya16": "洸哉_s_06",
    "shin16": "深_m_04",
    "torahiko16": "16日目",
    # === Day 17 ===
    "kounosuke17": "孝之助_m_05",
    "shun17": "峻_m_03",
    "torahiko17": "17日目",
    # === Day 18 ===
    "shun18": "峻_s_03",
    "torahiko18": "18日目",
    # === Day 19 ===
    "juuichi19": "柔一_m_05",
    "kouya19": "洸哉_s_07",
    "torahiko19": "19日目",
    # === Day 20 ===
    "tatsuki20": "辰樹_m_45",
    "shun20": "峻_s_04",
    "kouya20": "洸哉_m_01",
    "shin20": "深_m_05",
    "torahiko20": "20日目",
    # === Day 21 ===
    "kouya21": "洸哉_m_02",
    "torahiko21": "21日目",
    # === Day 22 (festival) ===
    "juuichi22": "柔一_m_06",
    "kounosuke22": "孝之助_m_n",
    "shun22": "峻_m_04",
    "kouya22": "洸哉_m_03",
    "shin22": "深_m_n",
    "tatsuki22": "辰樹_m_n",
    "torahiko22": "22日目",
    # === Day 23 ===
    "kouya23": "洸哉_m_035",
    "tatsuki23": "辰樹_m_06",
    "torahiko23": "23日目",
    # === Day 24 ===
    "kounosuke24": "孝之助_m_06",
    "shun24": "峻_s_06",
    "shin24": "深_m_06",
    "torahiko24": "24日目",
    # === Day 25 ===
    "tatsuki25": "辰樹_m_07",
    "kouya25": "洸哉_m_04",
    "torahiko25": "25日目",
    # === Day 26 ===
    "kounosuke26": "孝之助_m_07",
    "shun26": "峻_m_05",
    "kouya26": "洸哉_m_05",
    "shin26": "深_m_07",
    "torahiko26": "26日目",
    # === Day 27 ===
    "kouya27": "洸哉_m_06",
    "shin27": "深_m_08",
    "torahiko27": "27日目",
    # === Day 28 ===
    "tatsuki28": "辰樹_m_75",
    "shun28": "峻_s_02",
    "kouya28": "洸哉_m_07",
    "torahiko28": "28日目",
    # === Day 29 ===
    "juuichi29": "柔一_m_07",
    "kounosuke29": "孝之助_m_08",
    "kouya29": "洸哉_m_08",
    "tatsuki29": "辰樹_m_08",
    "torahiko29": "29日目",
    # === Day 30 ===
    "juuichi30": "柔一_m_08",
    "kounosuke30": "孝之助_m_09",
    "shun30": "峻_m_06",
    "kouya30": "洸哉_m_09",
    "tatsuki30": "辰樹_m_09",
    "shin30": "深_m_09",
    "torahiko30": "30日目",
    # === Welcome Party (sit_with_*) ===
    "sit_with": "虎彦",
    # === Endings ===
    "torahiko_ending": "虎彦",
    "tatsuki_ending": "辰樹",
    "kounosuke_ending": "孝之助",
    "shun_ending": "峻",
    "kouya_ending": "洸哉",
    "juuichi_ending": "柔一",
    "shin_ending": "深",
    # === Replay ===
    "nanafuse00": "replay",
}


def load_untranslated() -> list:
    """Load all untranslated entries."""
    entries = []
    if not UNTRANSLATED_DIR.exists():
        return entries

    for jsonl_file in sorted(UNTRANSLATED_DIR.glob("*.jsonl")):
        with open(jsonl_file, encoding="utf-8") as f:
            for line in f:
                e = json.loads(line)
                entries.append(e)
    return entries


def find_ks_match(entry_id: str) -> tuple[str, str]:
    """Find which KS file matches an entry ID.
    
    Returns:
        (ks_file, status) where status is "old" or "new"
    """
    label_prefix = entry_id.rsplit("_", 1)[0]

    # Exact match first
    if label_prefix in LABEL_TO_KS_MAP:
        return LABEL_TO_KS_MAP[label_prefix], "old"

    # Only match sub-labels if the parent prefix explicitly allows it
    # (e.g., day06_pick_kounosuke should NOT match day06)
    # For now, only exact matches are considered old translations.
    return "", "new"


def generate_structured_mapping():
    """Generate structured JSON mapping for programmatic use."""
    untranslated = load_untranslated()

    # Structure: {rpy_file: {label_prefix: {ks_file, entry_count, status}}}
    mapping = defaultdict(lambda: defaultdict(lambda: {
        "ks_file": "",
        "entry_count": 0,
        "status": "new",
        "entries": []
    }))

    for entry in untranslated:
        rpy_file = entry.get("file", "unknown")
        entry_id = entry.get("id", "")
        label_prefix = entry_id.rsplit("_", 1)[0]
        
        ks_file, status = find_ks_match(entry_id)

        entry_data = mapping[rpy_file][label_prefix]
        entry_data["entry_count"] += 1
        entry_data["status"] = status
        if ks_file:
            entry_data["ks_file"] = ks_file
        entry_data["entries"].append({
            "id": entry_id,
            "line": entry.get("line", 0),
            "source": entry.get("source", ""),
            "speaker": entry.get("speaker", "")
        })

    # Convert to plain dict for JSON serialization
    output = {}
    for rpy_file in sorted(mapping.keys()):
        output[rpy_file] = {}
        for label_prefix in sorted(mapping[rpy_file].keys()):
            info = mapping[rpy_file][label_prefix]
            output[rpy_file][label_prefix] = {
                "ks_file": info["ks_file"],
                "entry_count": info["entry_count"],
                "status": info["status"],
                "entries": info["entries"]
            }

    # Write JSON
    OUTPUT_MAPPING.parent.mkdir(parents=True, exist_ok=True)
    with open(OUTPUT_MAPPING, "w", encoding="utf-8") as f:
        json.dump(output, f, ensure_ascii=False, indent=2)

    # Print summary
    total_labels = sum(len(v) for v in output.values())
    total_entries = sum(
        info["entry_count"]
        for rpy in output.values()
        for info in rpy.values()
    )
    old_entries = sum(
        info["entry_count"]
        for rpy in output.values()
        for info in rpy.values()
        if info["status"] == "old"
    )
    new_entries = total_entries - old_entries

    print(f"Mapping generated: {OUTPUT_MAPPING}")
    print(f"  RPY files: {len(output)}")
    print(f"  Label prefixes: {total_labels}")
    print(f"  Total entries: {total_entries}")
    print(f"  Old translation entries: {old_entries}")
    print(f"  New content entries: {new_entries}")


if __name__ == "__main__":
    generate_structured_mapping()
