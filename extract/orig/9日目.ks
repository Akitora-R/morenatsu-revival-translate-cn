*start|８月９日
[initscene]

;[if exp="f.selopchr==1 || f.selopchr==2 || f.selopchr==3 || f.selopchr==4"]
[eval exp=kag.addBookMarkInfo("date",9)]
[SE 朝鳥の鳴き声 loop buf=1]
[daybegin day=９]
;[endif]

;[if exp="f.selopchr==1"]
;辰樹編

[主人公自室 日差し][wt]

【博行】
「今天做什么好呢？」

[msgoff]
[mselinit2]
[mseladd text="map_deficon" pos="辰樹の家" storage="辰樹_s_05.ks" exp="mapInfoFinalize()" onleave="mapInfoErase()" onenter="mapInfoWrite('辰樹の家','t')" target=*start]

;[elsif exp="f.selopchr==2"]
;孝之助編　心霊写真後日談。8日に移動

;[elsif exp="f.selopchr==3"]
;峻編

[mseladd text="map_deficon" pos="峻の家" storage="峻_s_07.ks" exp="mapInfoFinalize()" onleave="mapInfoErase()" onenter="mapInfoWrite('峻の家','u')" target=*start]

;[elsif exp="f.selopchr==4"]
;洸哉編

[mseladd text="map_deficon" pos="公園" storage="洸哉_s_04.ks" exp="mapInfoFinalize()" onleave="mapInfoErase()" onenter="mapInfoWrite('公園','y')" target=*start]
;★くぉメモ：場所は公園かな？

;[endif]

;深編
[mseladd text="map_deficon" pos="森" storage="深_m_03.ks" exp="mapInfoFinalize()" onleave="mapInfoErase()" onenter="mapInfoWrite('森','n')" target=*start]

;柔一編
[if exp="f.jyuichi_hate==0"]
[mseladd text="map_deficon" pos="田んぼと畑" storage="柔一_m_04.ks" exp="mapInfoFinalize()" onleave="mapInfoErase()" onenter="mapInfoWrite('田んぼと畑','j')" target=*start]
[endif]

[SE stop=100 buf=1][wf buf=1]
[BGM play=free0422]
[mselect2]

*nextday
[jump storage="10日目.ks" target="*start"]