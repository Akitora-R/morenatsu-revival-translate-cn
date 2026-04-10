*start|８月３日
[initscene]

;[if exp="f.selopchr==3"]
[eval exp=kag.addBookMarkInfo("date",03)]
[SE 朝鳥の鳴き声 loop buf=1]
[daybegin day=３]
;[endif]

;[if exp="f.selopchr==1"]
;辰樹編イベントなし
;[jump target="*nextday"]

;[elsif exp="f.selopchr==2"]
;孝之助編イベントなし
;[jump target="*nextday"]

;[elsif exp="f.selopchr==3"]
;峻編
[主人公自室 日差し][wt]

【博行】
「今天做什么呢？」

[msgoff]
[mselinit2]
[mseladd text="map_deficon" pos="公園" storage="峻_m_01.ks" exp="mapInfoFinalize()" onleave="mapInfoErase()" onenter="mapInfoWrite('公園','u')" target=*start]

;[elsif exp="f.selopchr==4"]
;洸哉編イベントなし
;[jump target="*nextday"]

;[endif]

;深編
[mseladd text="map_deficon" pos="商店街" storage="深_s_01.ks" exp="mapInfoFinalize()" onleave="mapInfoErase()" onenter="mapInfoWrite('商店街','n')" target=*start]


[SE stop=100 buf=1][wf buf=1]
[BGM play=free0422]
[mselect2]

*nextday
[jump storage="4日目.ks" target="*start"]