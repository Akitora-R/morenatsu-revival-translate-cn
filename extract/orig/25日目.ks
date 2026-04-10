*start|８月25日
[initscene]

[if exp="f.favochr==1 || f.favochr==4"]
[eval exp=kag.addBookMarkInfo("date",25)]
[SE 朝鳥の鳴き声 loop buf=1]
[daybegin day=25]
[endif]

[if exp="f.favochr==1"]
;辰樹編
[SE stop=100 buf=1][wf buf=1]
[jump storage="辰樹_m_07.ks" target="*start"]

[elsif exp="f.favochr==2"]
;孝之助編イベントなし
[jump target="*nextday"]

[elsif exp="f.favochr==3"]
;峻編イベントなし
[jump target="*nextday"]

[elsif exp="f.favochr==4"]
;洸哉編
[SE stop=100 buf=1][wf buf=1]
[jump storage="洸哉_m_04.ks" target="*start"]

[elsif exp="f.favochr==5"]
;柔一編
;イベントなし
[jump target="*nextday"]

[elsif exp="f.favochr==6"]
;深編
;イベントなし
[jump target="*nextday"]

[endif]

*nextday

[jump storage="26日目.ks" target="*start"]