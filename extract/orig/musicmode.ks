;
; 音楽mode
;

[rclick enabled=true jump=true storage="" target=*backtotitle]

[fadeoutbgm time=500]
[wb]

[eval exp='musicInit()']

*loop

; ベース画像読み込み
[stoptrans]
[backlay]
[position layer=message0 frame="titleorg" opacity=255 left=0 top=0 width=800 height=600 marginT=0 marginL=0 marginR=0 marginB=0 visible=true  transparent=false page=back]
[current layer=message0 page=back]

;遷移用ボタン
[locate x=397 y=33]
[button name="extra_cgmode" storage="cgmode.ks"]
[locate x=594 y=33]
[button name="extra_replaymode" storage="replay.ks"]
;[locate x=563 y=47]
;[button name="extra_musicmode" disabled]
[locate x=644 y=93]
[button name="extra_return" target=*backtotitle]

;機能ボタン
[locate x=140 y=484]
[button name="musicmode_play" exp="startBgm()"]
[locate x=  7 y=484]
[button name="musicmode_stop" exp="stopBgm()"]
[locate x=  7 y=530]
[button name="musicmode_repeat" exp='setRepeat(true)']
[locate x=140 y=530]
[button name="musicmode_allrepeat" exp='setRepeat(false)']

;音楽ボタン
[locate x=0 y=0]
[link exp='playBgm(0)'][emb exp="tf.musicmodelist[0].title"][endlink][r]
[link exp='playBgm(1)'][emb exp="tf.musicmodelist[1].title"][endlink][r]
[link exp='playBgm(2)'][emb exp="tf.musicmodelist[2].title"][endlink][r]
[link exp='playBgm(3)'][emb exp="tf.musicmodelist[3].title"][endlink][r]
[link exp='playBgm(4)'][emb exp="tf.musicmodelist[4].title"][endlink][r]
[link exp='playBgm(5)'][emb exp="tf.musicmodelist[5].title"][endlink][r]
[link exp='playBgm(6)'][emb exp="tf.musicmodelist[6].title"][endlink][r]
[link exp='playBgm(7)'][emb exp="tf.musicmodelist[7].title"][endlink][r]
[link exp='playBgm(8)'][emb exp="tf.musicmodelist[8].title"][endlink][r]
[link exp='playBgm(9)'][emb exp="tf.musicmodelist[9].title"][endlink][r]
[link exp='playBgm(10)'][emb exp="tf.musicmodelist[10].title"][endlink][r]
[link exp='playBgm(11)'][emb exp="tf.musicmodelist[11].title"][endlink][r]
[link exp='playBgm(12)'][emb exp="tf.musicmodelist[12].title"][endlink][r]

[eval exp='setRepeat()']
[eval exp='setMusicmodePageButton()']

[trans method=crossfade time=500]
[wt]
[current layer=message0 page=fore]
[s]

*backtotitle
[rclick enabled=false jump=false]
[eval exp='musicEnd()']
[jump storage="title.ks" target=*backtotitle]
