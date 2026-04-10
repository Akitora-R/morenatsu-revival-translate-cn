*start|８月19日
[initscene]

[if exp="f.favochr==4 || f.favochr==5"]
[eval exp=kag.addBookMarkInfo("date",19)]
[SE 朝鳥の鳴き声 loop buf=1]
[daybegin day=19]
[endif]

[if exp="f.favochr==1"]
;辰樹編イベントなし
[jump target="*nextday"]

[elsif exp="f.favochr==2"]
;孝之助編イベントなし
[jump target="*nextday"]

[elsif exp="f.favochr==3"]
;峻編イベントなし
[jump target="*nextday"]

[elsif exp="f.favochr==4"]
;洸哉編

[主人公自室 日差し][wt]

【博行】
「今天做什么好呢？」

[msgoff]
[mselinit2]
[mseladd text="map_deficon" pos="主人公の家" storage="洸哉_s_07.ks" exp="mapInfoFinalize()" onleave="mapInfoErase()" onenter="mapInfoWrite('主人公の家','y')" target=*start]

[elsif exp="f.favochr==5"]
;柔一編
[jump storage="柔一_m_05.ks" target="*start"]

[elsif exp="f.favochr==6"]
;深編
;イベントなし
[jump target="*nextday"]


[endif]

[SE stop=100 buf=1][wf buf=1]
[BGM play=free0422]
[mselect2]

*nextday
[jump storage="20日目.ks" target="*start"]