#!/usr/bin/env python3
import json
import re

CORRECT_CHINESE = {
    1123: "「深君！　深君！」",
    1138: "「[博行]……？」",
    1143: "「深君！？[l] 太好了。」",
    1153: "「[博行]！？」",
    1156: "「啊、嗯。没事吧？」",
    1162: "「为什么你会在这里啊！？」",
    1165: "「为什么，这个，",
    1172: "「因为看到深君走进了森林，有点担心就跟在后面看看，[l]然后发现深君倒在这里。」",
    1177: "「不过，看来好像没事的样子。[l]太好了。[wdt]刚看到的时候真的紧张到心脏都差点要跳出来了说。」",
    1182: "[fbig]「这不是理所当然的吗！」",
    1189: "「不、不过是要撞到了头的话，还是去检查一下比较好……」",
    1196: "「……」",
    1202: "「看来，你似乎完全误解了的样子。」",
    1218: "「只是在睡觉！？」",
    1221: "「……[l]",
    1223: "这个，也就是说，[wdt]深君只是在这里睡午觉而已吗？",
    1226: "「可是，怎么会把那个背包当成枕头……」",
    1229: "「虽然也有放别的东西，但已经用毛巾包起来了所以没问题。」",
    1233: "「……[l]为什么在这里睡啊？」",
    1238: "「……」",
    1244: "「我想在哪里睡觉跟你没有关系吧！」",
    1247: "「是！[wdt] 你说的没错。对不起。」",
    1253: "「不，抱歉。[l]我也知道就算跟你大吼也没用。」",
    1263: "「……[l]以前，[wdt]我曾经在别的地方像这样子在睡午觉。」",
    1277: "「那时候，似乎刚好孝之助从附近经过。[l]结果他就拍了我睡觉的样子。」",
    1282: "「啊。」",
    1288: "「哎，之后他拿那张照片来嘲笑我的时候，我把底片给一起处理掉了就是了。[l]因为被做过这种事，所以会紧张也是没办法的吧？」",
    1293: "「是、是……」",
    1299: "「不过既然是那家伙做的，应该只是在开玩笑吧？」",
    1304: "「开玩笑开成这样也太过份了！[l]而且，他还说了要拿到学校给大家看喔！？」",
    1308: "「是！」",
    1318: "「……[l]总之，就是这么回事。」",
    1321: "「是……」",
    1336: "「[博行]……」",
    1339: "「是！[l] 怎、怎么了？」",
    1349: "「[wds]如果这件事，让哪个人知道了的话，[l]就算是幼驯染我也绝不会原谅喔？[rd]」",
    1353: "「[wdm]……[rd][l][wds]是！我知道了！长官！[rd]」",
}

def normalize_text(text):
    if not text:
        return ""
    return re.sub(r'\s+', ' ', text).strip().lower()

def text_similarity(text1, text2):
    t1 = normalize_text(text1)
    t2 = normalize_text(text2)
    if t1 in t2 or t2 in t1:
        return 1.0
    words1 = set(t1.split())
    words2 = set(t2.split())
    if not words1 or not words2:
        return 0
    intersection = words1 & words2
    return len(intersection) / max(len(words1), len(words2))

MATCHING_RULES = [
    (1913, "Shin-kun raised his voice even further.{p}*sniff* {w=.3}I'm glad he's back to normal,\\nbut I really was worried.",
     "深君的声音更大了。[l]呜呜，[wdt]跟平常一样这点虽然让人很高兴，但[漏れ]可是真的非常担心的说。", "1184-1186"),
    (1914, "「B-but if you hit your head,\\n you should go get that...」",
     "「不、不过是要撞到了头的话，还是去检查一下比较好……」", "1189-1190"),
    (1918, "「...」",
     "「……」", "1196-1196"),
    (1922, "「It seems like you misunderstood things\\n from the very start.」",
     "「看来，你似乎完全误解了的样子。」", "1202-1202"),
    (1933, "「You were just sleeping!?」",
     "「只是在睡觉！？」", "1218-1218"),
    (1934, "「...{w} {nw}",
     "「……[l]", "1221-1221"),
    (1936, "yes.」",
     "这个，也就是说，[wdt]深君只是在这里睡午觉而已吗？", "1223-1223"),
    (1937, "Uh, then,{w=.3} so Shin-kun was napping?",
     "「可是，怎么会把那个背包当成枕头……」", "1226-1226"),
    (1938, "「Now that I think about it,\\n you used the backpack as a pillow.」",
     "「虽然也有放别的东西，但已经用毛巾包起来了所以没问题。」", "1229-1230"),
    (1939, "「I have stuff besides that,\\n but it's mostly stuffed with towels.」",
     "「……[l]为什么在这里睡啊？」", "1233-1233"),
    (1940, "「...{w} why over there?」",
     "「……」", "1238-1238"),
    (1944, "「...」",
     "「我想在哪里睡觉跟你没有关系吧！」", "1244-1244"),
    (1948, "「Where I sleep is none of your business!」",
     "「是！[wdt] 你说的没错。对不起。」", "1247-1247"),
    (1949, "「Yes!{w=.3} That's true. I'm sorry.」",
     "「不，抱歉。[l]我也知道就算跟你大吼也没用。」", "1253-1254"),
    (1953, "「No, I'm sorry.{p} I know things won't change by yelling at you.」",
     "「……[l]以前，[wdt]我曾经在别的地方像这样子在睡午觉。」", "1263-1264"),
    (1954, "Shin-kun calmed himself down\\nby shaking his head back and forth,\\nthen took a deep breath.",
     "深君像是要让自己冷静下来似地，摇了摇头之后深深吸了口气。", "1256-1257"),
    (1958, "「...{w} before,{w=.3} I've dozed off\\n like that in other places.」",
     "「那时候，似乎刚好孝之助从附近经过。[l]结果他就拍了我睡觉的样子。」", "1277-1279"),
    (1959, "Dozing...{w=.3} wait,\\nhe's all prepared and resolved to sleep...",
     "睡午觉，[wdt]也就是说，是有先做好准备，想好好地睡个觉的意思吗……", "1266-1267"),
    (1960, "I was so flustered earlier I didn't notice,\\nbut there was a vinyl sheet spread out.{p}Just enough space for one.",
     "刚刚因为慌张的关系没注意到，但其实草地上有铺着塑胶布。[l]刚好是一个人的宽度。", "1269-1271"),
    (1964, "「That time,\\n Kounosuke walked up all of a sudden.{p} Seems like he took a picture of me sleeping.」",
     "「啊。」", "1282-1282"),
    (1965, "「Huh.」",
     "「哎，之后他拿那张照片来嘲笑我的时候，我把底片给一起处理掉了就是了。[l]因为被做过这种事，所以会紧张也是没办法的吧？」", "1288-1290"),
    (1969, "「Anyways, when he came by laughing\\n wanting to show it off,\\n I disposed of it and the negatives.」",
     "「是、是……」", "1293-1293"),
    (1973, "「Well if that happens,\\n I have to be vigilant don't I?」",
     "「不过既然是那家伙做的，应该只是在开玩笑吧？」", "1299-1299"),
    (1974, "「Y-yeah...」",
     "「开玩笑开成这样也太过份了！[l]而且，他还说了要拿到学校给大家看喔！？」", "1304-1305"),
    (1975, "The negatives were disposed...{p}I know there are consequences,\\nbut sucks for Kounosuke.",
     "连底片都处理掉了……[l]虽然是自做自受，不过孝之助也挺可怜的。", "1295-1296"),
    (1976, "「Well if it was him, wasn't it just a joke?」",
     "「是！」", "1308-1308"),
    (1980, "「Even if it was a joke, it was horrible!{p} Everyone at school who saw it talked about it!」",
     "被平常几乎不会表露感情的深君给这样怒吼，让[漏れ]忍不住马上立正站好。[l]嗯，那样的话真的是太过份了点啦。", "1310-1312"),
    (1982, "The normally emotionally-controlled Shin-kun shouted,\\nand my spine instinctively stiffened.{p}Hmm, I guess I did overdo it.",
     "「……[l]总之，就是这么回事。」", "1318-1318"),
    (1986, "「...{w} and that's how it is.」",
     "「是……」", "1321-1321"),
    (1987, "「I see...」",
     "简单来说，[l]就是虽然想睡午觉，但是在村子里睡怕会被孝之助给拍下来，所以才特地到这种不会有人的森林中来睡，[wdt]这样。", "1323-1325"),
    (1988, "To summarize,{w} he wanted to take a nap,\\nbut he was afraid Kounosuke would take a picture.",
     "……[wdt]只是为了睡午觉有必要特地跑到这种地方来吗？[l]还是说会这么想的只有[漏れ]而已呢。", "1327-1329"),
    (1989, "So he chose to come here\\ninto the forest away from people.",
     "简直像是被黑暗的气场给包围，脸上一点笑容也没有的黑猫，用两只眼睛直盯着[漏れ]。", "1341-1343"),
    (1990, "...{w=.3}did he really need to come\\nall the way out here for a nap?{p}I'm probably the only one thinking that.",
     "「[博行]……」", "1336-1336"),
    (1995, "「[fn]...」",
     "「是！[l] 怎、怎么了？」", "1339-1339"),
    (1996, "「Yes?!!{w} W-what?」",
     "「[wds]如果这件事，让哪个人知道了的话，[l]就算是幼驯染我也绝不会原谅喔？[rd]」", "1349-1350"),
    (1997, "I looked into the two eyes of the black cat,\\nwho was unsmiling and held a gloomy aura.",
     "明明是夏天，[漏れ]的背后却有一大颗冷汗流了下来。", "1356-1357"),
    (2002, "「{cps=10}If you blab about this to anyone,\\n I won't ever forgive you for it -{p} {nw}",
     "「[wdm]……[rd][l][wds]是！我知道了！长官！[rd]」", "1353-1354"),
    (2004, "even if we're childhood friends. Got it?」",
     "「[博行]……」", "1336-1336"),
    (2005, "「{cps=10}...{cps=40}{p} {cps=10}YES-MY-MASTER.」",
     "「是！[l] 怎、怎么了？」", "1339-1339"),
    (2006, "Even if it was summer, I felt\\na terrible chill down my back.",
     "明明是夏天，[漏れ]的背后却有一大颗冷汗流了下来。", "1356-1357"),
]

def main():
    with open('translation_table.jsonl', 'r', encoding='utf-8') as f:
        lines = f.readlines()

    entries = []
    for line in lines:
        if line.strip():
            entries.append(json.loads(line.strip()))

    fixed_entries = []
    fix_count = 0

    for entry in entries:
        if not entry.get('id', '').startswith('shin09_shout'):
            continue
        if entry.get('translation_source', '') == '深_m_04.ks':
            source_line = entry.get('source_line', 0)
            source_text = entry.get('source', '')

            for rule_line, rule_source, correct_trans, correct_ks_lines in MATCHING_RULES:
                if source_line == rule_line:
                    entry['translation'] = correct_trans
                    entry['translation_source'] = 'extract/orig/深_m_03.ks'
                    entry['ks_lines'] = correct_ks_lines
                    fix_count += 1
                    fixed_entries.append(entry)
                    print(f"Fixed source_line {source_line}: {source_text[:50]}...")
                    break

    print(f"\nTotal fixed: {fix_count} entries")

    with open('output/day09_shin_shout_fix.jsonl', 'w', encoding='utf-8') as f:
        for entry in fixed_entries:
            f.write(json.dumps(entry, ensure_ascii=False) + '\n')

    print(f"Written to output/day09_shin_shout_fix.jsonl")

if __name__ == '__main__':
    main()