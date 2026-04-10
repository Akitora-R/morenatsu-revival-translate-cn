*start|８月５日
[initscene]

;[if exp="f.selopchr==1 || f.selopchr==4"]
[eval exp=kag.addBookMarkInfo("date",05)]
[SE 朝鳥の鳴き声 loop buf=1]
[daybegin day=５]
;[endif]

;[if exp="f.selopchr==1"]
;辰樹編

[主人公自室 日差し][wt]

【博行】
「今天做什么呢？」

[msgoff]
[mselinit2]
[mseladd text="map_deficon" pos="商店街" storage="辰樹_s_06.ks" exp="mapInfoFinalize()" onleave="mapInfoErase()" onenter="mapInfoWrite('商店街','t')" target=*start]

;[elsif exp="f.selopchr==2"]
;孝之助編イベントなし
;[jump target="*nextday"]

;[elsif exp="f.selopchr==3"]
;峻編イベントなし
;[jump target="*nextday"]

;[elsif exp="f.selopchr==4"]
;洸哉編
[mseladd text="map_deficon" pos="商店街" storage="洸哉_s_02.ks" exp="mapInfoFinalize()" onleave="mapInfoErase()" onenter="mapInfoWrite('商店街','y')" target=*start]
;[endif]

;柔一編
[if exp="f.jyuichi_firefly==true"]
[mseladd text="map_deficon" pos="川原" storage="柔一_m_03.ks" exp="mapInfoFinalize()" onleave="mapInfoErase()" onenter="mapInfoWrite('川原','j')" target=*start]
[endif]

[SE stop=100 buf=1][wf buf=1]
[BGM play=free0422]
[mselect2]

*nextday
[jump storage="6日目.ks" target="*start"]