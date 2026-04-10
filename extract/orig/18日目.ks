*start|８月18日
[initscene]

[if exp="f.favochr==3"]
[eval exp=kag.addBookMarkInfo("date",18)]
[SE 朝鳥の鳴き声 loop buf=1]
[daybegin day=18]
[endif]

[if exp="f.favochr==1"]
;辰樹編イベントなし
[jump target="*nextday"]

[elsif exp="f.favochr==2"]
;孝之助編イベントなし
[jump target="*nextday"]

[elsif exp="f.favochr==3"]
;峻編

[主人公自室 日差し][wt]

【博行】
「今天做些什么呢？」

[msgoff]
[mselinit2]
[mseladd text="map_deficon" pos="水郷神社" storage="峻_s_03.ks" exp="mapInfoFinalize()" onleave="mapInfoErase()" onenter="mapInfoWrite('水郷神社','u')" target=*start]

[elsif exp="f.favochr==4"]
;洸哉編イベントなし
[jump target="*nextday"]

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
[jump storage="19日目.ks" target="*start"]