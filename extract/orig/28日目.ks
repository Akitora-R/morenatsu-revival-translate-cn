*start|８月28日
[initscene]

[if exp="f.favochr==1 || f.favochr==3 || f.favochr==4"]
[eval exp=kag.addBookMarkInfo("date",28)]
[SE 朝鳥の鳴き声 loop buf=1]
[daybegin day=28]
[endif]

[if exp="f.favochr==1"]
;辰樹編
[SE stop=100 buf=1][wf buf=1]
[jump storage="辰樹_m_75.ks" target="*start"]

[elsif exp="f.favochr==2"]
;孝之助編イベントなし
[jump target="*nextday"]

[elsif exp="f.favochr==3"]
;峻編
[主人公自室 日差し][wt]

【博行】
「今天做什么事好呢？」

[msgoff]
[mselinit2]
[mseladd text="map_deficon" pos="丘" storage="峻_s_02.ks" exp="mapInfoFinalize()" onleave="mapInfoErase()" onenter="mapInfoWrite('丘','u')" target=*start]

[elsif exp="f.favochr==4"]
;洸哉編
[SE stop=100 buf=1][wf buf=1]
[jump storage="洸哉_m_07.ks" target="*start"]

[elsif exp="f.favochr==5"]
;柔一編
;イベントなし
[jump target="*nextday"]

[elsif exp="f.favochr==6"]
;深編
;イベントなし
[jump target="*nextday"]

[endif]

[SE stop=100 buf=1][wf buf=1]
[BGM play=free0422]
[mselect2]

*nextday

[jump storage="29日目.ks" target="*start"]