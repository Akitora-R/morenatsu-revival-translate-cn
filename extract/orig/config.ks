; 
; 環境設定
;

; 右クリックメニューからの呼び出し
*startFromMenu
[rclick enabled=true jump=true storage="" target=*backtomenu]
[eval exp='tf.fromTitle = 0']
[jump target="*init_config"]

; ゲーム中からの呼び出し
*startFromGame
[rclick enabled=true jump=true storage="" target=*backtogame]
[eval exp='tf.fromTitle = 0']
[history enabled=false]
[jump target=*init_config]

; タイトルからの呼び出し
*startFromTitle
[rclick enabled=true jump=true storage="" target=*backtotitle]
[eval exp='tf.fromTitle = 1']

*init_config
[iscript]
var screenmode = new GraphicLayer(kag, kag.fore.base);
var effectmode = new GraphicLayer(kag, kag.fore.base);
var skipmode = new GraphicLayer(kag, kag.fore.base);

var screenmode_b = new GraphicLayer(kag, kag.back.base);
var effectmode_b = new GraphicLayer(kag, kag.back.base);
var skipmode_b = new GraphicLayer(kag, kag.back.base);
[endscript]
[eval exp='configInit()']

*buttons

; ベース画像読み込み
[backlay]
[position layer=message1 frame="config_base" left=0 top=0 width=800 height=600 marginT=0 marginL=0 marginR=0 marginB=0 visible=true  transparent=false page=back]
[current layer=message1 page=back]

; ボタンの配置

;画面モード
[locate x=56  y=201]
[button name="config_window"     exp='setScreenButton(true)']
[locate x=234 y=201]
[button name="config_fullscreen" exp='setScreenButton(false)']

;テキスト速度
[locate x=20 y=310]
[slider width=350 height=30 opacity=0 normal="slidebar" over="slidebar_over" min=0 max=10 value=kag.textspeed nohilight]

;オート速度
[locate x=20 y=420]
[slider width=350 height=30 opacity=0 normal="slidebar" over="slidebar_over" min=0 max=10 value=kag.autospeed nohilight]

;画面効果
[locate x=57 y=529]
[button name=config_effecton exp="setNoEffectButton(false)" clickse="on03"]
[locate x=244 y=529]
[button name=config_effectoff exp="setNoEffectButton(true)" clickse="on03"]

;スキップ
[locate x=467 y=198]
[button name="config_skipall" exp="setSkipButton(true)" clickse="on03"]
[locate x=618 y=198]
[button name="config_skipalrdy" exp="setSkipButton(false)" clickse="on03"]

; BGM音量
[locate x=429 y=310]
[slider width=350 height=30 opacity=0 normal="slidebar" over="slidebar_over" min=0 max=100 value=kag.bgmvolume nohilight]

; SE音量
[locate x=429 y=420]
[slider width=350 height=30 opacity=0 normal="slidebar" over="slidebar_over" min=0 max=100 value=kag.sevolume nohilight]

; VOICE音量
;[locate x=431 y=336]
;[slider width=303 height=28 opacity=0 normal="slidebar" over="slidebar_over" min=0 max=100 value=kag.voicevolume nohilight]

; ボイスボタン
;[locate x=432 y=434]
;[button name="config_voice0" normal="config_voice0_on" exp="setVoiceOnButton('voice0')"]
;[locate x=526 y=434]
;[button name="config_voice1" normal="config_voice1_on" exp="setVoiceOnButton('voice1')"]
;[locate x=621 y=434]
;[button name="config_voice2" normal="config_voice2_on" exp="setVoiceOnButton('voice2')"]
;[locate x=432 y=480]
;[button name="config_voice3" normal="config_voice3_on" exp="setVoiceOnButton('voice3')"]
;[locate x=526 y=480]
;[button name="config_voice4" normal="config_voice4_on" exp="setVoiceOnButton('voice4')"]
;[locate x=621 y=480]
;[button name="config_voice5" normal="config_voice5_on" exp="setVoiceOnButton('voice5')"]

;初期化
[locate x=538 y=522]
[button name="config_initial" exp="initial()"]

;戻るボタン
[if exp="tf.fromTitle"]
[locate x=609 y=33]
[button name="config_title" target=*backtotitle clickse="pi47"]
[else]
[locate x=656 y=33]
[button name="config_return" target=*backtogame clickse="pi47"]
[locate x=469 y=33]
[button name="config_title" clickse="pi47" exp="gotoTitle()"]
[endif]

[if exp="tf.showMenu"]
[eval exp='configbotton()']
[trans method="universal" rule="左上から右下へ" vague="10" time=150]
[wt]
[eval exp='configInit2()']
[current layer=message1 page=fore]
[else]
[eval exp='configbotton()']
[trans method=crossfade time=300]
[wt]
[eval exp='configInit2()']
[current layer=message1 page=fore]
[endif]
[s]

*backtogame
[if exp="tf.showMenu"]
[jump target="*backtomenu"]
[else]
[rclick call=true storage="rclick.ks" target="*rclick" enabled=true]
[stoptrans]
[eval exp='configExit()']
[backlay]
[position layer=message1 page=back visible=false frame="" left=0 top=0 width=8 height=8]
[trans method=crossfade time=300]
[wt]
[current layer=message0]
[history enabled=true]
[jump target="*endconfig"]
[endif]

*backtomenu
[rclick jump=false]
[stoptrans]
[eval exp='configExit()']
[rclick jump=true storage="rclick.ks" target="*exit" enabled=true]
[stoptrans]
[backlay]
[position layer=message1 page=back visible=false frame="" left=0 top=0 width=8 height=8]
[trans method="universal" rule="右下から左上へ" vague="10" time=150]
[wt]
[current layer=message4 page=fore]

*endconfig
[return]

*backtotitle
[rclick enabled=false jump=false]
[eval exp='configExit()']
[current layer=message0]
[jump storage="title.ks" target=*backtotitle]