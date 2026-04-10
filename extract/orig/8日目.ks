*start|８月８日
[initscene]

;[if exp="f.favochr==1 || f.favochr==2 || f.favochr==4"]
[eval exp=kag.addBookMarkInfo("date",8)]
[SE 朝鳥の鳴き声 loop buf=1]
[daybegin day=８]
;[endif]



;[elsif exp="f.selopchr==2"]
;孝之助編　心霊写真後日談
;孝之助サブイベント2が終わっていたら解禁
;かつ強制発動
[if exp="f.konosuke_s2_end == true"]
[mseladd text="map_deficon" pos="商店街" storage="孝之助_s_03.ks" exp="mapInfoFinalize()" onleave="mapInfoErase()" onenter="mapInfoWrite('商店街','o')" target=*start]


[else]


;[if exp="f.selopchr==1"]
;辰樹編

[主人公自室 日差し][wt]

【博行】
「今天做什么好呢？」

[msgoff]
[mselinit2]
[mseladd text="map_deficon" pos="水郷神社" storage="辰樹_s_07.ks" exp="mapInfoFinalize()" onleave="mapInfoErase()" onenter="mapInfoWrite('水郷神社','t')" target=*start]


;[elsif exp="f.selopchr==3"]
;峻編イベントなし
;[jump target="*nextday"]

;[elsif exp="f.selopchr==4"]
;洸哉編
[mseladd text="map_deficon" pos="森" storage="洸哉_s_03.ks" exp="mapInfoFinalize()" onleave="mapInfoErase()" onenter="mapInfoWrite('森','y')" target=*start]

[endif]

[SE stop=100 buf=1][wf buf=1]
[BGM play=free0422]
[mselect2]

*nextday
[jump storage="9日目.ks" target="*start"]