*msg
;-----------------------------------
;★くぉメモ：
;[fbig]などのフォント指定の前には、
;半角スペースが必要なようです。
;また、その半角スペースを削除するため、
;直後に[er]を指定しています。
;[font size=○]は
;なぜか機能しません。
;-----------------------------------
[linemode mode=none]
[nowait][er]
[if exp="tf.msgno == 1"]
 [er][fbigbig]あとがきが
追加されました！
　
ギャラリーをチェックだ！[fdef]
[elsif exp="tf.msgno == 2"]

[endif][endnowait][linemode mode=free][nor]

[return]