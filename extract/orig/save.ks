;
; セーブ画面
;

; 右クリックメニューからの呼び出し
*startFromMenu
[rclick enabled=true jump=true storage="" target=*backtomenu]
[jump target="*startSave"]

; ゲーム中からの呼び出し
*startFromGame
[locksnapshot]
[rclick enabled=true jump=true storage="" target=*backtogame]
[history enabled=false]

*startSave
; ベース画像読み込み
[stoptrans]
[backlay]
[position layer=message1 frame="save_base" opacity=255 left=0 top=0 width=800 height=600 marginT=0 marginL=0 marginR=0 marginB=0 visible=true  transparent=false page=back]
[current layer=message1 page=back]

; ボタンの配置

;ページ配置
[locate x=17 y=285]
[button name="page1" exp="setSavePageButton(1)"]
[locate x=57 y=285]
[button name="page2" exp="setSavePageButton(2)"]
[locate x=97 y=285]
[button name="page3" exp="setSavePageButton(3)"]
[locate x=137 y=285]
[button name="page4" exp="setSavePageButton(4)"]
[locate x=177 y=285]
[button name="page5" exp="setSavePageButton(5)"]
[locate x=17 y=340]
[button name="page6" exp="setSavePageButton(6)"]
[locate x=57 y=340]
[button name="page7" exp="setSavePageButton(7)"]
[locate x=97 y=340]
[button name="page8" exp="setSavePageButton(8)"]
[locate x=137 y=340]
[button name="page9" exp="setSavePageButton(9)"]

;ページUPDOWNボタン
[locate x=774 y=45]
[button name="sl_up" exp="setSavePageButton(sf.loadpage-1 >= 1 ? (sf.loadpage-1) : 1)"]
[locate x=770 y=536]
[button name="sl_down" exp="setSavePageButton(sf.loadpage+1 <= 9 ? (sf.loadpage+1) : 9)"]

;セーブデータフレーム
;１列目
[locate x=240  y=36 ]
[button name="save0" normal="sl_win_base" exp="saveAction(0)"]
[locate x=240  y=176]
[button name="save1" normal="sl_win_base" exp="saveAction(1)"]
[locate x=240  y=315]
[button name="save2" normal="sl_win_base" exp="saveAction(2)"]
[locate x=240  y=453]
[button name="save3" normal="sl_win_base" exp="saveAction(3)"]
;[locate x=32  y=480]
;[button name="save4" normal="sl_win_base" exp="saveAction(4)"]

;２列目
;[locate x=400 y= 96]
;[button name="save5" normal="sl_win_base" exp="saveAction(5)"]
;[locate x=400 y=192]
;[button name="save6" normal="sl_win_base" exp="saveAction(6)"]
;[locate x=400 y=288]
;[button name="save7" normal="sl_win_base" exp="saveAction(7)"]
;[locate x=400 y=384]
;[button name="save8" normal="sl_win_base" exp="saveAction(8)"]
;[locate x=400 y=480]
;[button name="save9" normal="sl_win_base" exp="saveAction(9)"]

;左下戻るボタン
[locate x=54 y=421]
[if exp="tf.showMenu"]
[button name="return" target=*backtomenu]
[else]
[button name="return" target=*backtogame]
[endif]

; ダイアログ処理開始
[eval exp='setSavePageButton()']
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
[current layer=message0 page=fore]
;復帰時にメッセージウィンドウのselprosesslockを解除
[eval exp="kag.fore.messages[0].storedSelProcessLock = false"]
[history enabled=true]
[unlocksnapshot]
[jump target="*endsave"]

*backtomenu
[rclick jump=true storage="rclick.ks" target="*exit" enabled=true]
[stoptrans]
[backlay]
[position layer=message1 page=back visible=false frame="" left=0 top=0 width=8 height=8]
[trans method="universal" rule="右下から左上へ" vague="10" time=150]
[wt]
[current layer=message4 page=fore]

*endsave
[return]