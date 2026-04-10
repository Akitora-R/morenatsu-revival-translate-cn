*start|８月26日
[initscene]

[if exp="f.favochr==2 || f.favochr==3 || f.favochr==4 || f.favochr==6"]
[eval exp=kag.addBookMarkInfo("date",26)]
[SE 朝鳥の鳴き声 loop buf=1]
[daybegin day=26]
[endif]

[if exp="f.favochr==1"]
;辰樹編イベントなし
[jump target="*nextday"]

[elsif exp="f.favochr==2"]
;孝之助編
[SE stop=100 buf=1][wf buf=1]
[jump storage="孝之助_m_07.ks" target="*start"]

[elsif exp="f.favochr==3"]
;峻編
[SE stop=100 buf=1][wf buf=1]
[jump storage="峻_m_05.ks" target="*start"]

[elsif exp="f.favochr==4"]
;洸哉編
[SE stop=100 buf=1][wf buf=1]
[jump storage="洸哉_m_05.ks" target="*start"]

[elsif exp="f.favochr==5"]
;柔一編
;イベントなし
[jump target="*nextday"]

[elsif exp="f.favochr==6"]
;深編
[SE stop=100 buf=1][wf buf=1]
[jump storage="深_m_07.ks" target="*start"]

[endif]

*nextday

[jump storage="27日目.ks" target="*start"]