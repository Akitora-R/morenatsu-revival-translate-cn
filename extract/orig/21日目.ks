*start|８月21日
[initscene]

[if exp="f.favochr==4"]
[eval exp=kag.addBookMarkInfo("date",21)]
[SE 朝鳥の鳴き声 loop buf=1]
[daybegin day=21]
[endif]

[if exp="f.favochr==1"]
;辰樹編シナリオなし
[jump target="*nextday"]

[elsif exp="f.favochr==2"]
;孝之助編シナリオなし
[jump target="*nextday"]

[elsif exp="f.favochr==3"]
;峻編シナリオなし
[jump target="*nextday"]

[elsif exp="f.favochr==4"]
;洸哉編
[SE stop=100 buf=1][wf buf=1]
[jump storage="洸哉_m_02.ks" target="*start"]

[elsif exp="f.favochr==5"]
;柔一編
;イベントなし
[jump target="*nextday"]

[elsif exp="f.favochr==6"]
;深編
;イベントなし
[jump target="*nextday"]

[endif]

[SE stop=100 buf=1][wf buf=1]
[BGM play=free0422]
[mselect2]

*nextday
[jump storage="22日目.ks" target="*start"]