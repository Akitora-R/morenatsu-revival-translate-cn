*start|８月17日
[initscene]

[if exp="f.favochr==3 && f.shun_good!==true"]
;★くぉメモ：峻ルートかつ岳さんに会っていないとき、
;★メイン3は発生しない
[jump target="*nextday"]
[endif]

[if exp="f.favochr==2 || f.favochr==3"]
[eval exp=kag.addBookMarkInfo("date",17)]
[SE 朝鳥の鳴き声 loop buf=1]
[daybegin day=17]
[endif]

[if exp="f.favochr==1"]
;辰樹編イベントなし
;20日にジャンプ
[jump target="*nextday"]

[elsif exp="f.favochr==2"]
;孝之助編
[SE stop=100 buf=1][wf buf=1]
[jump storage="孝之助_m_05.ks" target="*start"]

[elsif exp="f.favochr==3"]
;峻編
[SE stop=100 buf=1][wf buf=1]
[jump storage="峻_m_03.ks" target="*shunmain03-07"]

[elsif exp="f.favochr==4"]
;洸哉編イベントなし
[jump target="*nextday"]

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
[jump storage="18日目.ks" target="*start"]