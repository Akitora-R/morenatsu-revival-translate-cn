#!/usr/bin/env python3
"""
Analyze route differences between old KS and new RPY.
Covers: day files, Welcome Party, Endings, Replay, and special KS files (camp, beach, ending, opening).
Generates comprehensive Markdown documentation.
"""

import re
import json
from pathlib import Path
from collections import defaultdict

print = lambda *args, **kwargs: __builtins__.print(*args, **{**kwargs, "flush": True})

RPY_SOURCE = Path("/home/aki/data/Projects/renpy/morenatsu-revival/game")
KS_ORIG = Path("extract/orig")
KS_TORAHIKO = Path("extract/torahiko")
TEXTS_DIR = Path("output/texts")
OUTPUT_DOC = Path("docs/route_differences.md")

CHARACTER_MAP = {
    "torahiko": "虎彦",
    "shin": "深",
    "kounosuke": "孝之助",
    "kouya": "洸哉",
    "shun": "峻",
    "tatsuki": "辰樹",
    "juuichi": "柔一",
    "candy": "甘味処（共通）",
    "kyoutarou": "京慈",
    "nanafuse": "七伏",
}

RPY_SPECIAL_FILES = [
    "Welcome Party.rpy",
    "Endings.rpy",
    "Replay.rpy",
    "initname.rpy",
    "nameinput.rpy",
]

KS_SPECIAL_FILES = {
    "orig": [
        "キャンプ01.ks",
        "キャンプ02.ks",
        "c_海水浴.ks",
        "オープニング.ks",
        "エンディング.ks",
    ],
    "torahiko": ["オープニング.ks", "エンディング.ks"],
}


def get_rpy_file_info(rpy_filename: str) -> dict:
    """Extract route info from any RPY source file."""
    rpy_file = RPY_SOURCE / rpy_filename
    if not rpy_file.exists():
        return {}

    with open(rpy_file, encoding="utf-8") as f:
        content = f.read()

    routes = {}
    label_pattern = r"label\s+(\w+):"
    focus_pattern = r'\$\s*focus_character\s*=\s*"(\w+)"'
    event_pattern = r'\$\s*event_name\s*=\s*"([^"]+)"'

    labels = [(m.start(), m.group(1)) for m in re.finditer(label_pattern, content)]
    seen_labels = set()

    for i, (pos, label) in enumerate(labels):
        if label in seen_labels:
            continue
        seen_labels.add(label)
        end_pos = labels[i + 1][0] if i + 1 < len(labels) else len(content)
        block = content[pos:end_pos]

        focus_m = re.search(focus_pattern, block)
        event_m = re.search(event_pattern, block)

        focus = focus_m.group(1) if focus_m else None
        event = event_m.group(1) if event_m else None

        routes[label] = {
            "focus": focus,
            "event": event,
            "character": CHARACTER_MAP.get(focus, focus) if focus else None,
        }

    return routes


def get_rpy_day_route_info(day_num: int) -> dict:
    """Extract route info from RPY day source file."""
    rpy_file = None
    for f in RPY_SOURCE.glob("*.rpy"):
        if re.match(rf".*day\s*{day_num}\.rpy", f.name, re.IGNORECASE):
            rpy_file = f
            break

    if not rpy_file:
        return {}

    with open(rpy_file, encoding="utf-8") as f:
        content = f.read()

    routes = {}
    label_pattern = r"label\s+(\w+):"
    focus_pattern = r'\$\s*focus_character\s*=\s*"(\w+)"'
    event_pattern = r'\$\s*event_name\s*=\s*"([^"]+)"'

    labels = [(m.start(), m.group(1)) for m in re.finditer(label_pattern, content)]
    seen_labels = set()

    for i, (pos, label) in enumerate(labels):
        if label in seen_labels:
            continue
        seen_labels.add(label)
        end_pos = labels[i + 1][0] if i + 1 < len(labels) else len(content)
        block = content[pos:end_pos]

        focus_m = re.search(focus_pattern, block)
        event_m = re.search(event_pattern, block)

        focus = focus_m.group(1) if focus_m else None
        event = event_m.group(1) if event_m else None

        routes[label] = {
            "focus": focus,
            "event": event,
            "character": CHARACTER_MAP.get(focus, focus) if focus else None,
        }

    return routes


def get_ks_day_refs(day_num: int) -> list:
    """Get route file references from old KS day file."""
    day_ks = f"{day_num}日目.ks"
    refs = []
    for ks_dir in [KS_TORAHIKO, KS_ORIG]:
        ks_path = ks_dir / day_ks
        if ks_path.exists():
            with open(ks_path, encoding="utf-8") as f:
                content = f.read()
            for m in re.finditer(r'storage="([^"]+\.ks)"', content):
                refs.append({"file": m.group(1), "dir": ks_dir.name})
    return refs


def get_ks_route_files(day_num: int) -> dict:
    """Get all KS route files referenced by a day file, organized by character."""
    refs = get_ks_day_refs(day_num)
    char_files = defaultdict(list)

    torahiko_day = KS_TORAHIKO / f"{day_num}日目.ks"
    if torahiko_day.exists():
        char_files["虎彦"].append(
            {"file": f"{day_num}日目.ks (虎彦路线)", "dir": "torahiko"}
        )

    for ref in refs:
        ks_file = ref["file"]
        matched = False
        for char_key, char_name in CHARACTER_MAP.items():
            if char_name in ks_file or char_key in ks_file:
                char_files[char_name].append({"file": ks_file, "dir": ref["dir"]})
                matched = True
                break
        if not matched:
            char_files["其他"].append({"file": ks_file, "dir": ref["dir"]})
    return dict(char_files)


def get_ks_special_route_files(ks_filename: str) -> dict:
    """Analyze special KS files (camp, beach, ending, opening) for character routes."""
    char_files = defaultdict(list)

    if ks_filename == "c_海水浴.ks":
        char_files["共通"].append({"file": "c_海水浴.ks", "dir": "orig"})
        for ks_dir in [KS_ORIG]:
            ks_path = ks_dir / ks_filename
            if ks_path.exists():
                with open(ks_path, encoding="utf-8") as f:
                    content = f.read()
                for char_key, char_name in CHARACTER_MAP.items():
                    if f"【{char_name}】" in content:
                        char_files[char_name].append(
                            {"file": "c_海水浴.ks", "dir": "orig"}
                        )
        return dict(char_files)

    if ks_filename in ["キャンプ01.ks", "キャンプ02.ks"]:
        ks_path = KS_ORIG / ks_filename
        if ks_path.exists():
            with open(ks_path, encoding="utf-8") as f:
                content = f.read()
            for char_key, char_name in CHARACTER_MAP.items():
                if f"【{char_name}】" in content:
                    char_files[char_name].append({"file": ks_filename, "dir": "orig"})
            if "f.favochr" in content:
                char_files["共通（分岐）"].append({"file": ks_filename, "dir": "orig"})
        return dict(char_files)

    if ks_filename in ["オープニング.ks", "エンディング.ks"]:
        for ks_dir_name, ks_dir in [("orig", KS_ORIG), ("torahiko", KS_TORAHIKO)]:
            ks_path = ks_dir / ks_filename
            if ks_path.exists():
                with open(ks_path, encoding="utf-8") as f:
                    content = f.read()
                if ks_filename == "エンディング.ks":
                    for char_key, char_name in CHARACTER_MAP.items():
                        if f"【{char_name}】" in content or char_key in content:
                            char_files[char_name].append(
                                {
                                    "file": f"{ks_filename} ({ks_dir_name})",
                                    "dir": ks_dir_name,
                                }
                            )
                else:
                    char_files["共通"].append(
                        {"file": f"{ks_filename} ({ks_dir_name})", "dir": ks_dir_name}
                    )
        return dict(char_files)

    return {}


def get_untranslated_stats_for_file(rpy_filename: str) -> dict:
    """Get untranslated entry stats grouped by label for a specific RPY file."""
    label_groups = defaultdict(list)
    untranslated_dir = TEXTS_DIR / "untranslated"
    if untranslated_dir.exists():
        for jsonl_file in sorted(untranslated_dir.glob("*.jsonl")):
            with open(jsonl_file) as f:
                for line in f:
                    e = json.loads(line)
                    if e.get("file", "").lower() == rpy_filename.lower():
                        bid = e.get("id", "")
                        label = bid.rsplit("_", 1)[0]
                        label_groups[label].append(e)
    return dict(label_groups)


def analyze_day(day_num: int) -> dict:
    """Analyze a specific day's routes."""
    rpy_routes = get_rpy_day_route_info(day_num)
    ks_route_files = get_ks_route_files(day_num)
    untranslated_stats = get_untranslated_stats_for_file(f"day {day_num}.rpy")

    ks_characters = set(ks_route_files.keys()) - {"其他"}

    label_analysis = []
    for label in sorted(rpy_routes.keys()):
        route_info = rpy_routes[label]
        character = route_info.get("character") or "未知"
        is_in_ks = character in ks_characters
        entry_count = len(untranslated_stats.get(label, []))
        label_analysis.append(
            {
                "label": label,
                "character": character,
                "event": route_info.get("event"),
                "in_ks": is_in_ks,
                "entry_count": entry_count,
            }
        )

    ks_files_flat = []
    for char, files in ks_route_files.items():
        for f in files:
            ks_files_flat.append(
                {"character": char, "file": f["file"], "dir": f["dir"]}
            )

    return {
        "type": "day",
        "name": f"Day {day_num}",
        "rpy_file": f"day {day_num}.rpy",
        "rpy_routes": rpy_routes,
        "ks_route_files": ks_route_files,
        "ks_characters": ks_characters,
        "label_analysis": label_analysis,
        "untranslated_stats": untranslated_stats,
        "ks_files": ks_files_flat,
        "total_labels": len(label_analysis),
        "labels_in_ks": sum(1 for l in label_analysis if l["in_ks"]),
        "labels_new": sum(1 for l in label_analysis if not l["in_ks"]),
        "entries_in_ks": sum(l["entry_count"] for l in label_analysis if l["in_ks"]),
        "entries_new": sum(l["entry_count"] for l in label_analysis if not l["in_ks"]),
    }


def analyze_special_rpy(rpy_filename: str) -> dict:
    """Analyze a special RPY file (Welcome Party, Endings, Replay, etc.)."""
    rpy_routes = get_rpy_file_info(rpy_filename)
    untranslated_stats = get_untranslated_stats_for_file(rpy_filename)

    display_name = rpy_filename.replace(".rpy", "")

    label_analysis = []
    for label in sorted(rpy_routes.keys()):
        route_info = rpy_routes[label]
        character = route_info.get("character") or "未知"
        entry_count = len(untranslated_stats.get(label, []))

        is_in_ks = False
        if "ending" in label.lower() and character != "未知":
            is_in_ks = True
        if "sit_with_" in label and character != "未知":
            is_in_ks = True

        label_analysis.append(
            {
                "label": label,
                "character": character,
                "event": route_info.get("event"),
                "in_ks": is_in_ks,
                "entry_count": entry_count,
            }
        )

    return {
        "type": "special_rpy",
        "name": display_name,
        "rpy_file": rpy_filename,
        "rpy_routes": rpy_routes,
        "label_analysis": label_analysis,
        "untranslated_stats": untranslated_stats,
        "ks_files": [],
        "total_labels": len(label_analysis),
        "labels_in_ks": sum(1 for l in label_analysis if l["in_ks"]),
        "labels_new": sum(1 for l in label_analysis if not l["in_ks"]),
        "entries_in_ks": sum(l["entry_count"] for l in label_analysis if l["in_ks"]),
        "entries_new": sum(l["entry_count"] for l in label_analysis if not l["in_ks"]),
    }


def analyze_special_ks(ks_filename: str, ks_dir_name: str) -> dict:
    """Analyze a special KS file."""
    ks_route_files = get_ks_special_route_files(ks_filename)
    ks_characters = set(ks_route_files.keys()) - {"其他"}

    ks_files_flat = []
    for char, files in ks_route_files.items():
        for f in files:
            ks_files_flat.append(
                {"character": char, "file": f["file"], "dir": f["dir"]}
            )

    return {
        "type": "special_ks",
        "name": ks_filename,
        "ks_route_files": ks_route_files,
        "ks_characters": ks_characters,
        "ks_files": ks_files_flat,
        "total_labels": 0,
        "labels_in_ks": 0,
        "labels_new": 0,
        "entries_in_ks": 0,
        "entries_new": 0,
    }


def generate_markdoc(all_data: list):
    """Generate comprehensive Markdown documentation."""
    lines = []
    lines.append("# 原版与新版本路线差异对比文档")
    lines.append("")
    lines.append(
        "> 本文档以 RPY 文件为准，对比原版 Kirikiri (.ks) 脚本与新版本 Ren'Py (.rpy) 脚本的路线差异。"
    )
    lines.append(
        "> 涵盖：Day 文件、Welcome Party、Endings、Replay 以及特殊 KS 文件（キャンプ、海水浴、エンディング等）。"
    )
    lines.append("")
    lines.append("## 目录")
    lines.append("")
    lines.append("- [总览](#总览)")
    lines.append("- [各天详细对比](#各天详细对比)")
    for d in all_data:
        name_slug = d["name"].lower().replace(" ", "-")
        lines.append(f"  - [{d['name']}](#{name_slug})")
    lines.append("- [特殊文件对比](#特殊文件对比)")
    for d in all_data:
        if d["type"] != "day":
            name_slug = d["name"].lower().replace(" ", "-")
            lines.append(f"  - [{d['name']}](#{name_slug})")
    lines.append("- [新增路线汇总](#新增路线汇总)")
    lines.append("- [删除路线汇总](#删除路线汇总)")
    lines.append("")

    lines.append("## 总览")
    lines.append("")
    lines.append(
        "| 文件/天数 | 类型 | RPY 标签数 | 旧版存在标签 | 新版独有标签 | 旧版存在条目 | 新版独有条目 |"
    )
    lines.append(
        "|-----------|------|-----------|-------------|-------------|-------------|-------------|"
    )
    for d in all_data:
        type_label = {"day": "Day", "special_rpy": "特殊RPY", "special_ks": "特殊KS"}[
            d["type"]
        ]
        lines.append(
            f"| {d['name']} | {type_label} | {d['total_labels']} | {d['labels_in_ks']} | {d['labels_new']} | {d['entries_in_ks']} | {d['entries_new']} |"
        )
    lines.append("")

    lines.append("## 各天详细对比")
    lines.append("")

    for d in all_data:
        if d["type"] != "day":
            continue

        lines.append(f"### {d['name']}")
        lines.append("")

        if d["ks_files"]:
            lines.append("#### 旧版 KS 路线文件")
            lines.append("")
            lines.append("| 角色 | 文件名 | 来源目录 |")
            lines.append("|------|--------|---------|")
            for kf in d["ks_files"]:
                lines.append(f"| {kf['character']} | {kf['file']} | {kf['dir']} |")
            lines.append("")

        lines.append("#### RPY 路线标签对比")
        lines.append("")
        lines.append("| 标签 | 角色 | 事件 | 条目数 | 旧版状态 |")
        lines.append("|------|------|------|--------|---------|")
        for la in d["label_analysis"]:
            status = "✓ 旧版存在" if la["in_ks"] else "✗ 新版独有"
            event = la["event"] or "-"
            lines.append(
                f"| {la['label']} | {la['character']} | {event} | {la['entry_count']} | {status} |"
            )
        lines.append("")

        new_labels = [la for la in d["label_analysis"] if not la["in_ks"]]
        if new_labels:
            lines.append("#### 新版独有路线")
            lines.append("")
            for la in new_labels:
                lines.append(
                    f"- **{la['label']}** ({la['character']}): {la['entry_count']} 条未翻译文本"
                )
            lines.append("")

        lines.append("---")
        lines.append("")

    lines.append("## 特殊文件对比")
    lines.append("")

    for d in all_data:
        if d["type"] == "day":
            continue

        lines.append(f"### {d['name']}")
        lines.append("")
        lines.append(f"**类型**: {d['type']}")
        lines.append("")

        if d.get("ks_files"):
            lines.append("#### 旧版 KS 对应文件/角色")
            lines.append("")
            lines.append("| 角色 | 文件名 | 来源目录 |")
            lines.append("|------|--------|---------|")
            for kf in d["ks_files"]:
                lines.append(f"| {kf['character']} | {kf['file']} | {kf['dir']} |")
            lines.append("")

        if d.get("label_analysis"):
            lines.append("#### RPY 路线标签对比")
            lines.append("")
            lines.append("| 标签 | 角色 | 事件 | 条目数 | 旧版状态 |")
            lines.append("|------|------|------|--------|---------|")
            for la in d["label_analysis"]:
                status = "✓ 旧版存在" if la["in_ks"] else "✗ 新版独有"
                event = la["event"] or "-"
                lines.append(
                    f"| {la['label']} | {la['character']} | {event} | {la['entry_count']} | {status} |"
                )
            lines.append("")

            new_labels = [la for la in d["label_analysis"] if not la["in_ks"]]
            if new_labels:
                lines.append("#### 新版独有路线")
                lines.append("")
                for la in new_labels:
                    lines.append(
                        f"- **{la['label']}** ({la['character']}): {la['entry_count']} 条未翻译文本"
                    )
                lines.append("")

        lines.append("---")
        lines.append("")

    lines.append("## 新增路线汇总")
    lines.append("")
    lines.append("以下是仅在 Ren'Py 新版本中出现、在原版 KS 中不存在的路由标签：")
    lines.append("")
    lines.append("| 文件/天数 | 标签 | 角色 | 条目数 |")
    lines.append("|-----------|------|------|--------|")
    for d in all_data:
        for la in d.get("label_analysis", []):
            if not la["in_ks"]:
                lines.append(
                    f"| {d['name']} | {la['label']} | {la['character']} | {la['entry_count']} |"
                )
    lines.append("")

    lines.append("## 删除路线汇总")
    lines.append("")
    lines.append("以下是原版 KS 中存在、但在 Ren'Py 新版本中已删除的路线文件：")
    lines.append("")

    all_rpy_chars = set()
    for d in all_data:
        for la in d.get("label_analysis", []):
            if la["character"] and la["character"] not in (
                "未知",
                "共通",
                "共通（分岐）",
            ):
                all_rpy_chars.add(la["character"])

    all_ks_chars_with_files = {}
    for d in all_data:
        for kf in d.get("ks_files", []):
            char = kf["character"]
            if char not in ("其他", "共通", "共通（分岐）"):
                if char not in all_ks_chars_with_files:
                    all_ks_chars_with_files[char] = set()
                all_ks_chars_with_files[char].add(d["name"])

    deleted_routes = []
    for char, files in all_ks_chars_with_files.items():
        if char not in all_rpy_chars:
            deleted_routes.append({"character": char, "files": sorted(files)})

    if deleted_routes:
        lines.append("| 角色 | 出现文件 |")
        lines.append("|------|---------|")
        for dr in deleted_routes:
            files_str = ", ".join(dr["files"])
            lines.append(f"| {dr['character']} | {files_str} |")
        lines.append("")
    else:
        lines.append("未发现完全删除的路线。")
        lines.append("")

    OUTPUT_DOC.parent.mkdir(parents=True, exist_ok=True)
    with open(OUTPUT_DOC, "w", encoding="utf-8") as f:
        f.write("\n".join(lines))

    print(f"文档已生成: {OUTPUT_DOC}")


def main():
    import argparse

    parser = argparse.ArgumentParser(
        description="Analyze route differences between KS and RPY"
    )
    parser.add_argument(
        "--day", type=int, default=None, help="Day to analyze (omit for all)"
    )
    parser.add_argument(
        "--output", action="store_true", help="Generate Markdown documentation"
    )
    args = parser.parse_args()

    if args.day:
        data = analyze_day(args.day)
        print(f"\n{'=' * 60}")
        print(f"Day {data['name']} Route Analysis")
        print(f"{'=' * 60}")
        print(f"\nRPY routes ({data['total_labels']}):")
        for la in data["label_analysis"]:
            status = "✓ 旧版存在" if la["in_ks"] else "✗ 新版独有"
            print(
                f"  {la['label']}: character={la['character']}, entries={la['entry_count']}, {status}"
            )
        print(f"\nOld KS references: {len(data['ks_files'])}")
        for kf in data["ks_files"]:
            print(f"  {kf['file']} ({kf['character']})")
        print(f"\nSummary:")
        print(
            f"  旧版存在: {data['labels_in_ks']} labels, {data['entries_in_ks']} entries"
        )
        print(f"  新版独有: {data['labels_new']} labels, {data['entries_new']} entries")
    else:
        all_data = []

        for day in range(1, 31):
            data = analyze_day(day)
            if data["total_labels"] > 0 or data["ks_files"]:
                all_data.append(data)

        for rpy_file in RPY_SPECIAL_FILES:
            if (RPY_SOURCE / rpy_file).exists():
                data = analyze_special_rpy(rpy_file)
                if data["total_labels"] > 0:
                    all_data.append(data)

        for ks_dir_name, ks_files in KS_SPECIAL_FILES.items():
            for ks_file in ks_files:
                data = analyze_special_ks(ks_file, ks_dir_name)
                if data["ks_files"]:
                    all_data.append(data)

        if args.output:
            generate_markdoc(all_data)
        else:
            for d in all_data:
                print(
                    f"{d['name']}: {d['total_labels']} labels, {d['labels_in_ks']} in KS, {d['labels_new']} new"
                )


if __name__ == "__main__":
    main()
