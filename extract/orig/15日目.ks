*start|８月15日
[initscene]
;共通イベントキャンプ
[eval exp=kag.addBookMarkInfo("date",15)]
[SE 朝鳥の鳴き声 loop buf=1]
[daybegin day=15]
[SE stop=100 buf=1][wf buf=1]
[jump storage="キャンプ02.ks" target="*start"]

*nextday
[jump storage="16日目.ks" target="*start"]