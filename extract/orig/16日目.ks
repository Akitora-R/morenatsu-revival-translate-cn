*start|８月16日
[initscene]

[if exp="f.favochr==3 && f.shun_good!==true"]
[SE stop=100 buf=1][wf buf=1]
[eval exp=kag.addBookMarkInfo("char","峻")]
;★くぉメモ：峻ルートかつ岳さんに会っていないとき、
;★メイン3は発生しない
[jump target="*nextday"]
[endif]

[if exp="f.favochr==1 || f.favochr==2 || f.favochr==3 || f.favochr==4 || f.favochr==6"]
[eval exp=kag.addBookMarkInfo("date",16)]
[SE 朝鳥の鳴き声 loop buf=1]
[daybegin day=16]
[endif]

[if exp="f.favochr==1"]
;辰樹編
[eval exp=kag.addBookMarkInfo("char","辰樹")]
[主人公自室 日差し][wt]

【博行】
「今天做什么好呢？」

[msgoff]
[mselinit2]
[mseladd text="map_deficon" pos="辰樹の家" storage="辰樹_m_04.ks" exp="mapInfoFinalize()" onleave="mapInfoErase()" onenter="mapInfoWrite('辰樹の家','t')" target=*start]

[elsif exp="f.favochr==2"]
;孝之助編
[SE stop=100 buf=1][wf buf=1]
[eval exp=kag.addBookMarkInfo("char","孝之助")]
[jump storage="孝之助_m_04.ks" target="*start"]
;マップ移動なし
[jump target="*nextday"]

[elsif exp="f.favochr==3"]
;峻編
[SE stop=100 buf=1][wf buf=1]
[eval exp=kag.addBookMarkInfo("char","峻")]
[jump storage="峻_m_03.ks" target="*start"]
;マップ移動なし
[jump target="*nextday"]

[elsif exp="f.favochr==4"]
;洸哉編
[eval exp=kag.addBookMarkInfo("char","洸哉")]
[主人公自室 日差し][wt]

【博行】
「今天做什么好呢？」

[msgoff]
[mselinit2]
[mseladd text="map_deficon" pos="商店街" storage="洸哉_s_06.ks" exp="mapInfoFinalize()" onleave="mapInfoErase()" onenter="mapInfoWrite('商店街','y')" target=*start]


[elsif exp="f.favochr==5"]
;柔一編
;イベントなし
[eval exp=kag.addBookMarkInfo("char","柔一")]
[jump target="*nextday"]


[elsif exp="f.favochr==6"]
;深編
;マップ移動なし
[eval exp=kag.addBookMarkInfo("char","深")]
[jump storage="深_m_04.ks" target="*start"]


[endif]

[SE stop=100 buf=1][wf buf=1]
[BGM play=free0422]
[mselect2]

*nextday
[jump storage="17日目.ks" target="*start"]