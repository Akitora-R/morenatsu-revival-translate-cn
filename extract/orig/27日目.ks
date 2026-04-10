*start|８月27日
[initscene]

[if exp="f.favochr==4 || f.favochr==6"]
[eval exp=kag.addBookMarkInfo("date",27)]
[SE 朝鳥の鳴き声 loop buf=1]
[daybegin day=27]
[endif]

[if exp="f.favochr==1"]
;辰樹編イベントなし
[jump target="*nextday"]

[elsif exp="f.favochr==2"]
;孝之助編イベントなし
[jump target="*nextday"]

[elsif exp="f.favochr==3"]
;峻編イベントなし
[jump target="*nextday"]

[elsif exp="f.favochr==4"]
;洸哉編
[SE stop=100 buf=1][wf buf=1]
[jump storage="洸哉_m_06.ks" target="*start"]


[elsif exp="f.favochr==5"]
;柔一編
;イベントなし
[jump target="*nextday"]

[elsif exp="f.favochr==6"]
;深編
[SE stop=100 buf=1][wf buf=1]
[jump storage="深_m_08.ks" target="*start"]

[endif]

*nextday

[jump storage="28日目.ks" target="*start"]