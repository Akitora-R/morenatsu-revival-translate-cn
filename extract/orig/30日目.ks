*start|８月30日
[initscene]

[eval exp=kag.addBookMarkInfo("date",30)]
[SE 朝鳥の鳴き声 loop buf=1]
[daybegin day=30]
[SE stop=100 buf=1][wf buf=1]

[if exp="f.favochr==1"]
;辰樹編
[jump storage="辰樹_m_09.ks" target="*start"]

[elsif exp="f.favochr==2"]
;孝之助編
[主人公自室 日差し][wt]
[jump storage="孝之助_m_09.ks" target="*start"]

[elsif exp="f.favochr==3"]
;峻編
[jump storage="峻_m_06.ks" target="*start"]

[elsif exp="f.favochr==4"]
;洸哉編
[jump storage="洸哉_m_09.ks" target="*start"]

[elsif exp="f.favochr==5"]
;柔一編
[jump storage="柔一_m_08.ks" target="*start"]

[elsif exp="f.favochr==6"]
;深編
[jump storage="深_m_09.ks" target="*start"]

[endif]

*nextday

[jump storage="エンディング.ks" target="*start"]