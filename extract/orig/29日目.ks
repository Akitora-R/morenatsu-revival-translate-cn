*start|８月29日
[initscene]

[if exp="f.favochr==1 || f.favochr==2 || f.favochr==4 || f.favochr==5"]
[eval exp=kag.addBookMarkInfo("date",29)]
[if exp="f.favochr!=1"]
;辰樹イベは朝鳥の鳴き声ナシ
[SE 朝鳥の鳴き声 loop buf=1]
[endif]
[daybegin day=29]
[endif]

[if exp="f.favochr==1"]
;辰樹編
[jump storage="辰樹_m_08.ks" target="*start"]

[elsif exp="f.favochr==2"]
;孝之助編
[主人公自室 日差し][wt]
[SE stop=100 buf=1][wf buf=1]
[jump storage="孝之助_m_08.ks" target="*start"]

[elsif exp="f.favochr==3"]
;峻編イベントなし
[jump target="*nextday"]

[elsif exp="f.favochr==4"]
;洸哉編
[SE stop=100 buf=1][wf buf=1]
[jump storage="洸哉_m_08.ks" target="*start"]


[elsif exp="f.favochr==5"]
;柔一編
;イベントなし
[SE stop=100 buf=1][wf buf=1]
[jump storage="柔一_m_07.ks" target="*start"]

[elsif exp="f.favochr==6"]
;深編
;イベントなし
[jump target="*nextday"]


[endif]

*nextday

[jump storage="30日目.ks" target="*start"]