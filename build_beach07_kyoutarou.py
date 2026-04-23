#!/usr/bin/env python3
"""Build beach07_kyoutarou batch JSONL by mapping RPY blocks to KS Chinese translation lines."""

import json

# Read all beach07_kyoutarou entries from translation table
entries = []
with open("translation_table.jsonl", "r", encoding="utf-8") as f:
    for line in f:
        entry = json.loads(line)
        if entry["id"].startswith("beach07_kyoutarou"):
            entries.append(entry)

print(f"Loaded {len(entries)} entries")

# Complete mapping: (entry_index, ks_start, ks_end, is_dialogue, translation)
# Each entry_index corresponds to the entries list index (0-120)
# is_dialogue: True = dialogue (with 「」), False = narration (no 「」)
# translation: formatted Chinese text per rules

complete_mapping = [
    # 0: fn "Of course you're swimming too, right Kyouji?"
    # KS 3867
    (0, 3867, 3867, True, "「京慈你也在游泳啊？」"),

    # 1: ky "Ah. Everybody's been waiting a long time,{p} to come here."
    # KS 3871
    (1, 3871, 3871, True, "「啊，是啊。{p}大家都等了好久才到这里呢。"),

    # 2: ky "It would be a loss if we return,{p} without having fun. Right, Tarou?"
    # KS 3872
    (2, 3872, 3872, True, "如果我们不玩得尽兴一点，回去会很遗憾的。{p}对吧？　宗」"),

    # 3: so "Yep! I'm really gonna enjoy this day!{p} This is my first time goin' to the beach,{p} with Takahara-senpai!"
    # KS 3877-3878
    (3, 3877, 3878, True, "「是啊！{p}我今天要好好享受一下，{p}这还是我第一次跟着高原前辈来沙滩呢！」"),

    # 4: ky "Haha, it is. But you aren't going,{p} to get too hyper, are you?"
    # KS 3881-3882
    (4, 3881, 3882, True, "「哈哈，是啊，{p}但你也不至于这么激动吧？」"),

    # 5: so "I won't!{p} Ehehe..."
    # KS 3887
    (5, 3887, 3887, True, "「我没有啦！{p}呃呵呵……」"),

    # 6: narration "Soutarou-kun gets a little embarrassed,{p}and scratches his nose."
    # KS 3889
    (6, 3889, 3889, False, "宗太郎有点不好意思地摸了摸自己的鼻子，"),

    # 7: narration "By the way things are going,{p}we should be getting in the sea soon..."
    # KS 3890
    (7, 3890, 3890, False, "不知不觉，我们该回归正题了。我们应该尽快到海边去…"),

    # 8: ky "Okay, let's change our clothes first.{p} Where is the changing room...?"
    # KS 3894-3895
    (8, 3894, 3895, True, "「好了，我们先去换衣服吧，{p}更衣室在哪里呢？」"),

    # 9: fn "Oh, is that hut over there?{p} Everybody's walking over there."
    # KS 3898-3899
    (9, 3898, 3899, True, "「噢，那边应该就是更衣室吧？{p}大家都在往那边去呢。」"),

    # 10: ky "Looks like it...{p} should we head on over?"
    # KS 3902
    (10, 3902, 3902, True, "「看起来好像是呢…我们直接过去吗？」"),

    # 11: so "Oh, I'm goin' too!"
    # KS 3906
    (11, 3906, 3906, True, "「我也要去！」"),

    # 12: narration "We get to the changing room hut.{p}Good timing, it's already our turn."
    # KS 3910-3911
    (12, 3910, 3911, False, "我们到了更衣室，{p}不一会儿就轮到我们了。"),

    # 13: fn "All right, I'll get changed.{p} You two wait out here."
    # KS 3914
    (13, 3914, 3914, True, "「好了，我要换衣服了，你们俩先在外面等一下。」"),

    # 14: ky "Oh, I know."
    # KS 3918
    (14, 3918, 3918, True, "「噢，我知道了。」"),

    # 15: narration "Suddenly, Kyouji thinks of something and\nclaps his hands together."
    # KS 3920
    (15, 3920, 3920, False, "突然，京慈好像想到了什么似的，轻轻地拍了一下头。"),

    # 16: ky "Why don't all three of us go in together?"
    # KS 3923
    (16, 3923, 3923, True, "「为什么我们三个不一起进去换呢？」"),

    # 17: so "...!"
    # KS 3927
    (17, 3927, 3927, True, "「！」"),

    # 18: fn "Whaaaat!?"
    # KS 3930
    (18, 3930, 3930, True, "「什什什什……什么！？」"),

    # 19: narration "When Kyouji says that,{p}he has a serious look on his face."
    # KS 3932-3933
    (19, 3932, 3933, False, "京慈在说这句话的时候，{p}表情十分郑重。"),

    # 20: narration "He said that without any warning.{p}I shout from a strange place,{p}in the back of my throat."
    # KS 3935-3937
    (20, 3935, 3937, False, "说话之前也没有任何的预兆。{p}我太过激动，{p}从喉咙深处叫出来一声连我自己都不认识的声音。"),

    # 21: fn "Ch-change together?"
    # KS 3940
    (21, 3940, 3940, True, "「一起…一起换？」"),

    # 22: ky "Yeah. Three people going separately,{p} isn't very efficient, right?"
    # KS 3943
    (22, 3943, 3943, True, "「是啊。{p}三个人分开换太慢了不是么？"),

    # 23: ky "This way we won't keep the next person,{p} waiting until we're done."
    # KS 3944
    (23, 3944, 3944, True, "而且分开换的话，我们会让后面的人等太久的。」"),

    # 24: fn "I-I guess so, but...{p} H-hey? Soutarou-kun."
    # KS 3947-3948
    (24, 3947, 3948, True, "「我…我想也是吧…{p}对、{w=.3}对吧？{p}宗太郎君」"),

    # 25: narration "I glance over at him."
    # KS 3950
    (25, 3950, 3950, False, "我瞥了他一眼。"),

    # 26: narration "The small changing hut looks,{p}like it would be a bit crowded,{p}with 3 people inside."
    # KS 3952-3953
    (26, 3952, 3953, False, "更衣室这么小，{p}三个人一起进来的话，估计会有点儿挤吧。"),

    # 27: narration "But above all, I'll be in an enviroment,{p}where those two will be naked,{p}only a few centimeters away."
    # KS 3955-3956
    (27, 3955, 3956, False, "他们两个裸着上身，{p}离我只有一点点儿距离。"),

    # 28: narration "I have no idea how much,{p}of that I'll be able to resist."
    # KS 3957
    (28, 3957, 3957, False, "我脑袋里一片空白，都不知道手脚该往哪放。"),

    # 29: narration "Surely Soutarou-kun,{p}must be embarrassed about this..."
    # KS 3959
    (29, 3959, 3959, False, "不过我猜，宗太郎也对此有些尴尬…"),

    # 30: so "I don't see anything wrong with that..."
    # KS 3964-3965
    (30, 3964, 3965, True, "「？{p}吼哈，{w=.3}{w=.3}我不觉得这有什么不对劲的地方啊……」"),

    # 31: fn "Wh-Whaaat!?"
    # KS 3969
    (31, 3969, 3969, True, "「什、{w=.3}什么？？」"),

    # 32: narration "When Soutarou kun says that,{p}he has a serious look on his face."
    # KS 3971-3972
    (32, 3971, 3972, False, "宗太郎说这话的时候。{p}脸上写满了认真。"),

    # 33: ky "What's wrong, [fn]?{p} Your voice sounds strange."
    # KS 3975-3976
    (33, 3975, 3976, True, "「怎么了？{w=.3}　[fn]{p}你声音听起来怪怪的呢。」"),

    # 34: fn "N-no no! I-It's nothing!{p} You just suggested that so suddenly,{p} that it took me off guard, that's all."
    # KS 3979-3980
    (34, 3979, 3980, True, "「没、{w=.3}没事没事！{p}能、{w=.3}能有什么事啊！{p}你突然这么说，搞得我一时没反应过来{w=.3}而已。」"),

    # 35: ky "Is that so?{p} Anyway, let's get in.{p} We're holding those behind us up."
    # KS 3983-3984
    (35, 3983, 3984, True, "「是这样么？{p}不管怎么说，我们赶紧换衣服吧。{p}已经让后面的人等了很久了。」"),

    # 36: to "Hey [fn], hurry up and get in there,{p} Are you gonna skip your turn?"
    # KS 3987-3988
    (36, 3987, 3988, True, "「嘿，[fn]你倒是快点儿啊，{p}你还要不要换衣服啊！」"),

    # 37: fn "A-all right..."
    # KS 3991
    (37, 3991, 3991, True, "「好，好了，马上完了……」"),

    # 38: narration "Feeling the pressure from Torahiko,{p}we finally enter the changing room."
    # KS 3993-3994
    (38, 3993, 3994, False, "听到虎彦的催促，{p}最后我们三个还是一起进了更衣室。"),

    # 39: narration "As soon as we get in,{p}Kyouji immediately begins to undress."
    # KS 3999
    (39, 3999, 3999, False, "在我们进去的同时，京慈马上就开始脱衣服了。"),

    # 40: narration "I hesitate once, but I can't stand it,{p}I sometimes glance over them."
    # KS 4002-4003
    (40, 4002, 4003, False, "我愣了一下，{p}但是还是忍不住时不时的看看他们。"),

    # 41: narration "Huh? I'm not feeling guilty?"
    # KS 4005
    (41, 4005, 4005, False, "哈？{p}我居然没有内疚感？"),

    # 42: narration "Because we're changing,{p}with our backs facing each other,{p}they won't notice."
    # KS 4006-4007
    (42, 4006, 4007, False, "大概是因为我们都在换衣服，大家相互背对着，{p}……所以他们没有注意到我。"),

    # 43: narration "...I'll probably be safe."
    # KS 4007
    (43, 4007, 4007, False, "我大概还是安全的吧。"),

    # 44: narration "Kyouji has a tight body,{p}while Soutarou-kun's is slender and delicate."
    # KS 4009
    (44, 4009, 4009, False, "京慈的身体很紧致，宗太郎则比较修长细腻。"),

    # 45: narration "They've trained their bodies from soccer,{p}so there's no excess fat at all."
    # KS 4010-4011
    (45, 4010, 4011, False, "他们的身体已经在踢足球的时候得到锻炼了，{p}所以身上没有一丁点儿多余的脂肪。"),

    # 46: narration "I look down at my stomach and compare.{p}...I haven't been getting much excersise lately."
    # KS 4013-4014
    (46, 4013, 4014, False, "再看看我的肚腩…{p}……我已经很久没有运动了…身上已经有相当明显的赘肉。"),

    # 47: narration "Some fat is clearly showing.{p}I try pinching it with both of my hands."
    # KS 4015
    (47, 4015, 4015, False, "我试着把这些赘肉挤出来，"),

    # 48: narration "..Just as I expected, it's gotten pretty bad."
    # KS 4017
    (48, 4017, 4017, False, "……但是并没有得偿所愿，反而变的更糟了。"),

    # 49: so "Okay, I'm ready!"
    # KS 4026
    (49, 4026, 4026, True, "「好了，我换好啦！」"),

    # 50: ky "...Hm, [fn] you haven't...{p} changed yet?"
    # KS 4029
    (50, 4029, 4029, True, "「……嗯、[fn]，你还没换完么？」"),

    # 51: fn "Huh?"
    # KS 4032
    (51, 4032, 4032, True, "「啊哈？」"),

    # 52: narration "I turn my head. They're standing there,{p}already in their bathing suits.{p}Aaaah, I've failed my mission..."
    # KS 4034-4035
    (52, 4034, 4035, False, "我抬起头，他们已经站在那里了，早就换好了衣服。{p}啊啊啊啊啊，我又走神了……。"),

    # 53: so "Oh, did you forget somethin'?"
    # KS 4038
    (53, 4038, 4038, True, "「哦？你是不是忘记了什么东西了？」"),

    # 54: narration "Soutarou-kun asks.{p}Th-this pain in my chest is too much..."
    # KS 4040-4041
    (54, 4040, 4041, False, "宗太郎问道。{p}我突然感到胸口略疼……。"),

    # 55: fn "No, that's not it...{p} Th-that's right!"
    # KS 4044
    (55, 4044, 4044, True, "「没，没有…我没什么问题！……"),

    # 56: fn "My pants zipper is stuck!{p} I can't get it to go down..."
    # KS 4045-4046
    (56, 4045, 4046, True, "只，只是！{p}我的拉链坏了！{p}我拉不下来……」"),

    # 57: ky "I see...{p} Well, we'll go out first."
    # KS 4050
    (57, 4050, 4050, True, "「我明白了……{p}我们先出去吧。」"),

    # 58: ky "Let's go, Tarou."
    # KS 4053
    (58, 4053, 4053, True, "「走吧，宗。」"),

    # 59: so "Okay!"
    # KS 4057
    (59, 4057, 4057, True, "「好的！」"),

    # 60: narration "They put their clothes in their bags and leave."
    # KS 4061
    (60, 4061, 4061, False, "他们把衣服放在包里，然后先走了，"),

    # 61: narration "Now it's just me left in the hut."
    # KS 4063
    (61, 4063, 4063, False, "现在只剩下我一个人留在更衣室里。"),

    # 62: fn "...Anyway, shall I get changed?"
    # KS 4066
    (62, 4066, 4066, True, "「……还是说，其实是我变了？」"),

    # 63: narration "Feeling awkward, I pick up my bathing suit."
    # KS 4068
    (63, 4068, 4068, False, "这么想着，我拿起我的泳衣。"),

    # 64: narration "Finished changing, I return to the beach,{p}and I see everybody's in the water,{p}having a good time."
    # KS 4075-4076
    (64, 4075, 4076, False, "换完衣服我回到了沙滩上，{p}然后我看到大家都已经下水，享受美好时光了。"),

    # 65: narration "Now where did those two go..."
    # KS 4078
    (65, 4078, 4078, False, "他们俩现在在哪儿呢……"),

    # 66: narration "Ah, there they are.{p}I wave at them from the beach."
    # KS 4080
    (66, 4080, 4080, False, "啊，在那儿呢。{p}我在沙滩边朝他们挥了挥手，"),

    # 67: narration "I run straight down the sandy beach,{p}to where they are."
    # KS 4081
    (67, 4081, 4081, False, "我径直朝他们跑了过去。"),

    # 68: fn "Wait up!"
    # KS 4090
    (68, 4090, 4090, True, "「等等！」"),

    # 69: ky "Good. [fn] has arrived,{p} so we can start warming up first."
    # KS 4093-4094
    (69, 4093, 4094, True, "「好了。[fn]已经到了，{p}我们可以开始先热身了。」"),

    # 70: fn "Eh... but aren't we just swimming?{p} There's no need to warm up for that..."
    # KS 4097-4098
    (70, 4097, 4098, True, "「呃？但是我们不是来游泳的吗？{p}游泳还需要热身的吗？……」"),

    # 71: ky "Now now, [fn],{p} isn't being prepared for anything important?"
    # KS 4101
    (71, 4101, 4101, True, "「对啊，[fn]，准备工作非常重要不是么？"),

    # 72: ky "Your opponent is the sea.{p} It's different from the pool,{p} and the river."
    # KS 4102
    (72, 4102, 4102, True, "你的对手可是大海，不是小水池，或者小河什么的，"),

    # 73: ky "So if you don't prepare,{p} there's a chance you could even drown."
    # KS 4103
    (73, 4103, 4103, True, "如果你不做准备运动的话，你就有可能会溺水而亡了。」"),

    # 74: fn "That's overdoing it..."
    # KS 4106
    (74, 4106, 4106, True, "「这有点儿太夸张了…」"),

    # 75: ju "...No, there's a reason,{p} for Takahara's instructions."
    # KS 4111
    (75, 4111, 4111, True, "「……不，一点都不夸张，既然高原都这么说了。」"),

    # 76: fn "Whoa, Ju-Juuichi-san..."
    # KS 4114
    (76, 4114, 4114, True, "「哇啊，{w=.3}柔、{w=.3}柔一君……」"),

    # 77: narration "At my negligent reply,{p}Juuichi-san suddenly appears from behind."
    # KS 4116-4117
    (77, 4116, 4117, False, "在我马马虎虎地回答了京慈之后，{p}柔一君出现在了我的后面"),

    # 78: narration "I turn around and see him,{p}looking at me square in the eyes."
    # KS 4119
    (78, 4119, 4119, False, "我转过身看着他，与他充满严肃的双眼对视。"),

    # 79: ju "There's no such thing as being 100%% prepared.{p} However, thanks to the act of preparation,{p} you can recognize your own inexperience."
    # KS 4122-4124
    (79, 4122, 4124, True, "「俗话说有备无患。{p}不管怎么说，多亏了这准备工作，{p}你才能意识到自己的经验不足。"),

    # 80: ju "...Understand?"
    # KS 4124
    (80, 4124, 4124, True, "……懂了吗？」"),

    # 81: fn "Y-yeah...{p} I'll be more diligent..."
    # KS 4127
    (81, 4127, 4127, True, "「嗯…{w=.3}是……{p}我会更加努力的……」"),

    # 82: narration "I give him an agreeable response,{p}then get out of his focus.{p}Whew, that was scary..."
    # KS 4129-4131
    (82, 4129, 4131, False, "我积极地回应着他，{p}然后从他的视线中逃离了。{p}啊，好恐怖的脸……"),

    # 83: ju "So, I'll join in too.{p} Is that fine, Takahara?"
    # KS 4133-4135
    (83, 4133, 4135, True, "「所以，我也要加入。{p}没问题吧？{w=.3}　高原」"),

    # 84: ky "Oh, of course it is."
    # KS 4138
    (84, 4138, 4138, True, "「好，当然没问题了」"),

    # 85: narration "Then, we, along with Juuichi-san,{p}begin our warm up excercises on the beach."
    # KS 4142-4143
    (85, 4142, 4143, False, "然后，我跟着柔一君，{p}在沙滩边开始了热身运动。"),

    # 86: narration "In front of us, Kyouji leads the work-out."
    # KS 4145
    (86, 4145, 4145, False, "京慈则在前面领着我们一起做。"),

    # 87: narration "Since he's the captain of his club,{p}he's almost like a coach,{p}in the middle of pratice."
    # KS 4146-4147
    (87, 4146, 4147, False, "不管怎么说，他是他社团的负责人，{p}在热身运动的过程中他就像大家的教练一样。"),

    # 88: narration "The only difference,{p}is that we're in our bathing suits."
    # KS 4149
    (88, 4149, 4149, False, "唯一不同的是，我们都穿着泳衣。"),

    # 89: narration "Well, we were naked together...{p}but, for now I'll let this be my motivation."
    # KS 4150-4151
    (89, 4150, 4151, False, "好吧…其实我们都裸着身子…{p}但是，从现在开始我要提起干劲来！"),

    # 90: narration "..."
    # KS 4153
    (90, 4153, 4153, False, "……。"),

    # 91: ka "What's wrong, [fn]?{p} It's just a warm-up, but it looks like,{p} you're pulling your back all weird."
    # KS 4158-4159
    (91, 4158, 4159, True, "「怎么了，[fn]。{p}只是热身运动而已，可是你干嘛这么卖力地压背。」"),

    # 92: narration "Looking at my posture,{p}Kouya makes fun of me from behind."
    # KS 4161
    (92, 4161, 4161, False, "看着我的架势，洸哉忍不住在我身后吃吃笑了起来。"),

    # 93: fn "Th-this is nothing!{p} Besides, you're just standing there,{p} watching, you should join us."
    # KS 4163-4166
    (93, 4163, 4166, True, "「没…没事。{p}说起来，你只是站在那儿看，{p}你应该也跟我们一起来啊。」"),

    # 94: ka "Oh, I'm fine.{p} Even if I get a cramp or anything,{p} I'm sure I'll be able to manage somehow."
    # KS 4170-4172
    (94, 4170, 4172, True, "「哈，我没关系的。{p}就算我意外抽筋或者发生了别的什么，{p}我相信一定也有办法的。」"),

    # 95: fn "R-really..."
    # KS 4175
    (95, 4175, 4175, True, "「真…{w=.3}真的呢……」"),

    # 96: narration "His arm...{p}I don't think there would be any problem."
    # KS 4177-4178
    (96, 4177, 4178, False, "他健壮的胳膊…{p}对于如此壮硕的他，我想不出还有什么问题会让他溺水。"),

    # 97: ka "Well then, I should get back,{p} to swimming soon.{p} Good luck with the exercise."
    # KS 4182-4184
    (97, 4182, 4184, True, "「嗯，好，就这样吧，我该回去了，一会儿下水游泳去。{p}热身运动，加油。」"),

    # 98: narration "As he says that,{p}Kouya starts running down the beach."
    # KS 4188
    (98, 4188, 4188, False, "随着他远去，"),

    # 99: narration "As he departs, I give him a look of envy,{p}shake away my delusions,{p}and stretch the tendons in my foot."
    # KS 4189-4190
    (99, 4189, 4190, False, "我投去羡慕的目光，{p}打破自己脑海里的妄想，伸展了一下脚部肌肉。"),

    # 100: so "Senpai, let's hurry up and get in!"
    # KS 4206
    (100, 4206, 4206, True, "「前辈，我们快一点把热身运动做完吧！」"),

    # 101: ky "Oh, come on now, Tarou.{p} Don't rush too much."
    # KS 4209
    (101, 4209, 4209, True, "「嘿、嘿——宗。{p}别跑那么快。」"),

    # 102: narration "We finish warming up,{p}and head straight for the water."
    # KS 4211
    (102, 4211, 4211, False, "结束了热身运动，我们就开始准备下水了。"),

    # 103: narration "Soutarou-kun grabs on to Kyouji's arm,{p}and forcefully pulls him."
    # KS 4212
    (103, 4212, 4212, False, "宗太郎抓着京慈的手，用力把他拉下水。"),

    # 104: narration "First things first,{p}I get to the water's edge,{p}and try to soak my feet."
    # KS 4214
    (104, 4214, 4214, False, "我先是来到水边，开始将我的脚浸湿。"),

    # 105: narration "The clear waves caress my bare feet.{p}Ah, this... feels good..."
    # KS 4216-4217
    (105, 4216, 4217, False, "清澈的海浪拥抱着我的脚，{p}啊！这感觉…心旷神怡。"),

    # 106: ky "Hey, Tarou!"
    # KS 4222
    (106, 4222, 4222, True, "「嘿，宗！」"),

    # 107: narration "Kyouji swipes at the water's surface,{p}sending a spray of water,{p}in Soutarou-kun's direction."
    # KS 4224-4225
    (107, 4224, 4225, False, "京慈用手托起水，{p}朝宗太郎的方向泼过去"),

    # 108: so "Waah, s-senpai, please stop!"
    # KS 4229-4231
    (108, 4229, 4231, True, "「哇啊，{w=.3}前、{w=.3}前辈，{p}快停下啦！」"),

    # 109: narration "Soutarou-kun doesn't like how he's acting,{p}but he's enjoying it a little."
    # KS 4233
    (109, 4233, 4233, False, "宗太郎并没有表示不满，反而很有点享受的样子。"),

    # 110: narration "The sight of those two playing,{p}creates a romantic scene."
    # KS 4235-4236
    (110, 4235, 4236, False, "他们玩闹的场景，在水沫的反射中飞溅着阳光的碎片，{p}看起来真浪漫呢。"),

    # 111: narration "D-damn... I'm jealous...{p}If those two can show off like that,{p}then I...!"
    # KS 4238-4239
    (111, 4238, 4239, False, "啊、{w=.3}好吧…我有点嫉妒他们了。{p}如果他们也能跟我这么玩的话，我一定…！"),

    # 112: fn "Take this!"
    # KS 4244
    (112, 4244, 4244, True, "「看招！」"),

    # 113: so "Woah, you too, [ln]-san!?"
    # KS 4248
    (113, 4248, 4248, True, "「哇啊，[西村]也过来闹啊？」"),

    # 114: ky "All right, Tarou!{p} Now, focus your attack on [fn]!"
    # KS 4250-4252
    (114, 4250, 4252, True, "「好吧，宗！{p}现在，把咱们的火力点对准[fn]吧！」"),

    # 115: so "Okay!"
    # KS 4256
    (115, 4256, 4256, True, "「好！」"),

    # 116: ky "There!"
    # KS 4260
    (116, 4260, 4260, True, "「开火啦！！！」"),

    # 117: fn "Eh, you two are being unfair... Woah!"
    # KS 4263
    (117, 4263, 4263, True, "「啊，你们两个这样不公平…哇啊！」"),

    # 118: narration "Water is splashed at me,{p}from two different directions at once."
    # KS 4265
    (118, 4265, 4265, False, "同时从两个方向袭来的海水，泼得我满身都是。"),

    # 119: narration "I-I'm being attacked by two athletes,{p}I'm clearly at a disadvantage here!"
    # KS 4266
    (119, 4266, 4266, False, "被两个健壮的家伙欺负了，在这里处于不利位置啊！"),

    # 120: narration "Frolicking around the water like this,{p}it reminds me of how,{p}we used to play in the river."
    # KS 4268-4269
    (120, 4268, 4269, False, "这样的戏水场面，让我不禁想到，{p}以前我们在河边玩耍的日子。"),
]

# Verify we have exactly 121 entries
assert len(complete_mapping) == 121, f"Expected 121 mappings, got {len(complete_mapping)}"

# Verify all entry indices are unique and cover 0-120
used_indices = [m[0] for m in complete_mapping]
assert len(used_indices) == 121, f"Expected 121 unique indices, got {len(set(used_indices))}"
assert sorted(used_indices) == list(range(121)), "Indices don't cover 0-120"

# Build output
output_lines = []
issues = []

for idx, ks_start, ks_end, is_dialogue, translation in complete_mapping:
    entry = entries[idx]
    entry_id = entry["id"]
    
    ks_lines_str = f"{ks_start}-{ks_end}" if ks_start != ks_end else str(ks_start)
    
    # Validate translation format rules
    # Check dialogue has 「」 brackets
    if is_dialogue and not (translation.startswith("「") or translation.startswith("…")):
        issues.append(f"Entry {idx} ({entry_id}): Dialogue should start with 「")
    if is_dialogue and not translation.endswith("」"):
        # Some multi-block dialogues may not end with 」if split across blocks
        pass  # Allow this for multi-block splits
    
    # Check narration doesn't have 「」 (unless it's mixed narration/dialogue)
    if not is_dialogue and "「" in translation:
        issues.append(f"Entry {idx} ({entry_id}): Narration should not have 「 brackets")
    
    result = {
        "id": entry_id,
        "translation": translation,
        "translation_type": "旧版翻译",
        "translation_source": "c_海水浴.ks",
        "ks_lines": ks_lines_str
    }
    output_lines.append(json.dumps(result, ensure_ascii=False))

# Write output
with open("output/beach07_kyoutarou_batch.jsonl", "w", encoding="utf-8") as f:
    for line in output_lines:
        f.write(line + "\n")

print(f"Total entries written: {len(output_lines)}")
if issues:
    print(f"\nISSUES ({len(issues)}):")
    for issue in issues:
        print(f"  {issue}")
else:
    print("No issues found.")