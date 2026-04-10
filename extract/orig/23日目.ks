*start|８月23日
[initscene]

;孝之助イベントスキップの場合
[if exp="f.favochr==2 && f.kounosuke_badstep==true"]
[jump target="*nextday"]
[endif]

[if exp="f.favochr==1 || f.favochr==4"]
[eval exp=kag.addBookMarkInfo("date",23)]
[SE 朝鳥の鳴き声 loop buf=1]
[daybegin day=23]
[endif]

[if exp="f.favochr==1"]
;辰樹編
[SE stop=100 buf=1][wf buf=1]
[jump storage="辰樹_m_06.ks" target="*start"]

[elsif exp="f.favochr==2"]
;孝之助編
[jump storage="孝之助_m_055.ks" target="*start"]


[elsif exp="f.favochr==3"]
;峻編イベントなし
[jump target="*nextday"]

[elsif exp="f.favochr==4"]
;洸哉編
[SE stop=100 buf=1][wf buf=1]
[jump storage="洸哉_m_035.ks" target="*start"]

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

[jump storage="24日目.ks" target="*start"]