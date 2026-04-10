*start|８月14日
[initscene]
;共通イベントキャンプ
[eval exp=kag.addBookMarkInfo("date",14)]
[SE 朝鳥の鳴き声 loop buf=1]
[daybegin day=14]
[SE stop=100 buf=1][wf buf=1]
[jump storage="キャンプ01.ks" target="*shugoujikan"]

*nextday
[jump storage="15日目.ks" target="*start"]