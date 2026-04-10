;
; ロード画面
;

; 右クリックメニューからの呼び出し
*startFromMenu
[eval exp='tf.fromTitle = 0']
[rclick enabled=true jump=true storage="" target=*backtomenu]
[jump target="*buttons"]

; ゲーム中からの呼び出し
*startFromGame
[locksnapshot]
[eval exp='tf.fromTitle = 0']
[rclick enabled=true jump=true storage="" target=*backtogame]
[history enabled=false]
[jump target="*buttons"]

; タイトルからの呼び出し
*startFromTitle
[eval exp='tf.fromTitle = 1']
[rclick enabled=true jump=true storage="" target=*backtotitle]

*buttons

; ベース画像読み込み
[stoptrans]
[backlay]
[position layer=message1 frame="load_base" opacity=255 left=0 top=0 width=800 height=600 marginT=0 marginL=0 marginR=0 marginB=0 visible=true  transparent=false page=back]
[current layer=message1 page=back]

;ページ配置
[locate x=17 y=285]
[button name="page1" exp="setLoadPageButton(1)"]
[locate x=57 y=285]
[button name="page2" exp="setLoadPageButton(2)"]
[locate x=97 y=285]
[button name="page3" exp="setLoadPageButton(3)"]
[locate x=137 y=285]
[button name="page4" exp="setLoadPageButton(4)"]
[locate x=177 y=285]
[button name="page5" exp="setLoadPageButton(5)"]
[locate x=17 y=340]
[button name="page6" exp="setLoadPageButton(6)"]
[locate x=57 y=340]
[button name="page7" exp="setLoadPageButton(7)"]
[locate x=97 y=340]
[button name="page8" exp="setLoadPageButton(8)"]
[locate x=137 y=340]
[button name="page9" exp="setLoadPageButton(9)"]

;ページUPDOWNボタン
[locate x=774 y=45]
[button name="sl_up" exp="setLoadPageButton(sf.loadpage-1 >= 1 ? (sf.loadpage-1) : 1)"]
[locate x=770 y=536]
[button name="sl_down" exp="setLoadPageButton(sf.loadpage+1 <= 9 ? (sf.loadpage+1) : 9)"]

;セーブデータフレーム
;１列目
[locate x=240  y=36 ]
[button name="load0" normal="sl_win_base" exp="loadAction(0)"]
[locate x=240  y=176]
[button name="load1" normal="sl_win_base" exp="loadAction(1)"]
[locate x=240  y=315]
[button name="load2" normal="sl_win_base" exp="loadAction(2)"]
[locate x=240  y=453]
[button name="load3" normal="sl_win_base" exp="loadAction(3)"]
;[locate x=32  y=480]
;[button name="load4" normal="sl_win_base" exp="loadAction(4)"]

;２列目
;[locate x=400 y= 96]
;[button name="load5" normal="sl_win_base" exp="loadAction(5)"]
;[locate x=400 y=192]
;[button name="load6" normal="sl_win_base" exp="loadAction(6)"]
;[locate x=400 y=288]
;[button name="load7" normal="sl_win_base" exp="loadAction(7)"]
;[locate x=400 y=384]
;[button name="load8" normal="sl_win_base" exp="loadAction(8)"]
;[locate x=400 y=480]
;[button name="load9" normal="sl_win_base" exp="loadAction(9)"]

;戻るボタン
[locate x=54 y=421]
[if exp="tf.fromTitle == 0 && tf.showMenu == 1"]
[button name="return" target=*backtomenu]
[elsif exp="tf.fromTitle == 1"]
[button name="return" target=*backtotitle]
[else]
[button name="return" target=*backtogame]
[endif]

; ダイアログ処理開始
[eval exp='setLoadPageButton()']
[if exp="tf.showMenu"]
[trans method="universal" rule="左上から右下へ" vague="10" time=150]
[else]
[trans method=crossfade time=300]
[endif]
[wt]
[current layer=message1 page=fore]
[s]

*backtogame
[rclick call=true storage="rclick.ks" target="*rclick" enabled=true]
[stoptrans]
[backlay]
[position layer=message1 page=back visible=false frame="" left=0 top=0 width=8 height=8]
[trans method=crossfade time=300]
[wt]
[current layer=message0]
[history enabled=true]
[unlocksnapshot]
;復帰時にメッセージウィンドウのselprosesslockを解除
[eval exp="kag.fore.messages[0].storedSelProcessLock = false"]
[jump target="*endload"]

*backtomenu
[rclick jump=true storage="rclick.ks" target="*exit" enabled=true]
[stoptrans]
[backlay]
[position layer=message1 page=back visible=false frame="" left=0 top=0 width=8 height=8]
[trans method="universal" rule="右下から左上へ" vague="10" time=150]
[wt]
[current layer=message4 page=fore]

*endload
[return]

*backtotitle
[rclick enabled=false jump=false]
[jump storage="title.ks" target=*backtotitle]
