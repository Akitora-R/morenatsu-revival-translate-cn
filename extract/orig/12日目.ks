*start|８月12日
[initscene]

;[if exp="f.selopchr==1 || f.selopchr==4"]
[eval exp=kag.addBookMarkInfo("date",12)]
[SE 朝鳥の鳴き声 loop buf=1]
[daybegin day=12]
;[endif]

;[if exp="f.selopchr==1"]
;辰樹編

[主人公自室 日差し][wt]

【博行】
「今天做什么好呢？」

[msgoff]
[mselinit2]
[if exp="f.tatsuki_arbeit==1"]
;辰樹メインは１を見てないと通さない
[mseladd text="map_deficon" pos="辰樹の家" storage="辰樹_m_03.ks" exp="mapInfoFinalize()" onleave="mapInfoErase()" onenter="mapInfoWrite('辰樹の家','t')" target=*start]
[endif]

;[elsif exp="f.selopchr==2"]
;孝之助編イベントなし
;[jump target="*nextday"]

;[elsif exp="f.selopchr==3"]
;峻編イベントなし
;[jump target="*nextday"]

;[elsif exp="f.selopchr==4"]
;洸哉編
[mseladd text="map_deficon" pos="水郷神社" storage="洸哉_s_05.ks" exp="mapInfoFinalize()" onleave="mapInfoErase()" onenter="mapInfoWrite('水郷神社','y')" target=*start]

;柔一編
[if exp="f.jyuichi_hate==0"]
[mseladd text="map_deficon" pos="川原" storage="柔一_s_02.ks" exp="mapInfoFinalize()" onleave="mapInfoErase()" onenter="mapInfoWrite('川原','j')" target=*start]
[endif]

;[endif]

[SE stop=100 buf=1][wf buf=1]
[BGM play=free0422]
[mselect2]

*nextday
[jump storage="13日目.ks" target="*start"]