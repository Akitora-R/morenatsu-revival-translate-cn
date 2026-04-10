*start|８月２日
[initscene]

[eval exp=kag.addBookMarkInfo("date",02)]
[SE 朝鳥の鳴き声 loop buf=1]
[daybegin day=２]

;[if exp="f.selopchr==1"]
;辰樹編
;[eval exp=kag.addBookMarkInfo("char","辰樹")]

[主人公自室 日差し][wt]

【博行】
「今天做什么呢？」

[msgoff]
[mselinit2]
[mseladd text="map_deficon" pos="辰樹の家" storage="辰樹_m_01.ks" exp="mapInfoFinalize()" onleave="mapInfoErase()" onenter="mapInfoWrite('辰樹の家','t')" target=*start]

;[elsif exp="f.selopchr==2"]
;孝之助編
;[eval exp=kag.addBookMarkInfo("char","孝之助")]

[mseladd text="map_deficon" pos="商店街" storage="孝之助_m_01.ks" exp="mapInfoFinalize()" onleave="mapInfoErase()" onenter="mapInfoWrite('商店街','o')" target=*start]

;[elsif exp="f.selopchr==3"]
;峻編イベントなし
;[eval exp=kag.addBookMarkInfo("char","峻")]
;[jump target="*nextday"]

;[elsif exp="f.selopchr==4"]
;洸哉編
;[eval exp=kag.addBookMarkInfo("char","洸哉")]

[mseladd text="map_deficon" pos="川原" storage="洸哉_s_01.ks" exp="mapInfoFinalize()" onleave="mapInfoErase()" onenter="mapInfoWrite('川原','yu')" target=*start]

;深編
[mseladd text="map_deficon" pos="深の家" storage="深_m_01.ks" exp="mapInfoFinalize()" onleave="mapInfoErase()" onenter="mapInfoWrite('深の家','n')" target=*start]

;柔一編
[mseladd text="map_deficon" pos="田んぼと畑" storage="柔一_m_01.ks" exp="mapInfoFinalize()" onleave="mapInfoErase()" onenter="mapInfoWrite('田んぼと畑','j')" target=*start]


[SE stop=100 buf=1][wf buf=1]
[BGM play=free0422]
[mselect2]

*nextday
[jump storage="3日目.ks" target="*start"]