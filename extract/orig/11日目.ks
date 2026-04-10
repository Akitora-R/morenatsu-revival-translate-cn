*start|８月11日
[initscene]

;[if exp="f.selopchr==1"]
[eval exp=kag.addBookMarkInfo("date",11)]
[SE 朝鳥の鳴き声 loop buf=1]
[daybegin day=11]
;[endif]

;[if exp="f.selopchr==1"]
;辰樹編

[主人公自室 日差し][wt]

【博行】
「今天做什么好呢？」

[msgoff]
[mselinit2]

[favocheck]
[if exp="f.favochr==1"]
;全員参加イベントだから、辰樹好感度最高の時だけ単品で発動
[mseladd text="map_deficon" pos="川原" storage="辰樹_s_03.ks" exp="mapInfoFinalize()" onleave="mapInfoErase()" onenter="mapInfoWrite('川原','tusjkonyr')" target=*start]
[else]
;[elsif exp="f.selopchr==2"]
;孝之助編イベントなし
;[jump target="*nextday"]

;[elsif exp="f.selopchr==3"]
;峻編イベントなし
;[jump target="*nextday"]

;[elsif exp="f.selopchr==4"]
;洸哉編イベントなし
;[jump target="*nextday"]

;深編
[mseladd text="map_deficon" pos="深の家" storage="深_s_02.ks" exp="mapInfoFinalize()" onleave="mapInfoErase()" onenter="mapInfoWrite('深の家','n')" target=*start]

;柔一編
[if exp="f.jyuichi_hate==0"]
[mseladd text="map_deficon" pos="商店街" storage="柔一_s_01.ks" exp="mapInfoFinalize()" onleave="mapInfoErase()" onenter="mapInfoWrite('商店街','j')" target=*start]
[endif]

[endif]

[SE stop=100 buf=1][wf buf=1]
[BGM play=free0422]
[mselect2]

*nextday
[jump storage="12日目.ks" target="*start"]