*start|８月10日
[initscene]

;[if exp="f.selopchr==1 || f.selopchr==2 || f.selopchr==3"]
[eval exp=kag.addBookMarkInfo("date",10)]
[SE 朝鳥の鳴き声 loop buf=1]
[daybegin day=10]
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
[mseladd text="map_deficon" pos="辰樹の家" storage="辰樹_m_02.ks" exp="mapInfoFinalize()" onleave="mapInfoErase()" onenter="mapInfoWrite('辰樹の家','t')" target=*start]
[endif]

;[elsif exp="f.selopchr==2"]
;孝之助編
[mseladd text="map_deficon" pos="森" storage="孝之助_m_03.ks" exp="mapInfoFinalize()" onleave="mapInfoErase()" onenter="mapInfoWrite('森','o')" target=*start]

;[elsif exp="f.selopchr==3"]
;峻編

[mseladd text="map_deficon" pos="商店街" storage="峻_m_02.ks" exp="mapInfoFinalize()" onleave="mapInfoErase()" onenter="mapInfoWrite('商店街','u')" target=*start]

;[elsif exp="f.selopchr==4"]
;洸哉編イベントなし
;[jump target="*nextday"]

;柔一編
[if exp="f.jyuichi_rent==true"]
[if exp="f.shun_val>=3"]
;iwakメモ 峻君の好感度を上げている場合のみ発生
[mseladd text="map_deficon" pos="バス停" storage="柔一_m_045.ks" exp="mapInfoFinalize()" onleave="mapInfoErase()" onenter="mapInfoWrite('バス停','j')" target=*start]
;シナリオの実体どーこー？
[endif]
[endif]

;[endif]

[SE stop=100 buf=1][wf buf=1]
[BGM play=free0422]
[mselect2]

*nextday
[jump storage="11日目.ks" target="*start"]