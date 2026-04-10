*start|８月20日
[initscene]

[if exp="f.favochr==1 || f.favochr==3 || f.favochr==4 || f.favochr==6"]
[eval exp=kag.addBookMarkInfo("date",20)]
[SE 朝鳥の鳴き声 loop buf=1]
[daybegin day=20]
[endif]

[if exp="f.favochr==1"]
;辰樹編
;メイン４．５にジャンプ
[SE stop=100 buf=1][wf buf=1]
[jump storage="辰樹_m_45.ks" target="*start"]

[elsif exp="f.favochr==2"]
;孝之助編
;22日にジャンプ
[jump target="*nextday"]

[elsif exp="f.favochr==3"]
;峻編

[主人公自室 日差し][wt]

【博行】
「今天做些什么好呢？」

[msgoff]
[mselinit2]
[mseladd text="map_deficon" pos="主人公の家" storage="峻_s_04.ks" exp="mapInfoFinalize()" onleave="mapInfoErase()" onenter="mapInfoWrite('主人公の家','u')" target=*start]

[elsif exp="f.favochr==4"]
;洸哉編

[主人公自室 日差し][wt]

【博行】
「今天做什么好呢？」

[msgoff]
[mselinit2]
[mseladd text="map_deficon" pos="田んぼと畑" storage="洸哉_m_01.ks" exp="mapInfoFinalize()" onleave="mapInfoErase()" onenter="mapInfoWrite('田んぼと畑','y')" target=*start]

[elsif exp="f.favochr==5"]
;柔一編
;イベントなし
[jump target="*nextday"]

[elsif exp="f.favochr==6"]
;深編
[jump storage="深_m_05.ks" target="*start"]

[endif]

[SE stop=100 buf=1][wf buf=1]
[BGM play=free0422]
[mselect2]

*nextday
[jump storage="21日目.ks" target="*start"]