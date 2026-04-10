*init|タイトル
[eval exp='tf.recollect = 0']
[eval exp='tf.showMenu = 0']
[startanchor]

*start|
[disablestore]
[clickskip enabled=true]
[cancelskip]
[cancelautomode]
[linemode]
[rclick enabled=false]
[history enabled=false]
[stoprecollection]
[clearhistory]

*dispstart

; 各種初期化
[iscript]
mapInfoFinalize();
if(timer !== void)	invalidate timer;
if(clock !== void)	invalidate clock;
[endscript]
[init]
[mappfont storage="umefont.tft"]
[clearlayers]
[clearlayers page="back"]
[stopbgm]
[stopvideo]
[video visible=false]
[eval exp='configExit()']

;フラグ変数初期化

; 回想モードに強制遷移
[if exp="tf.recollect"]
[eval exp='tf.recollect = 0']
;BGMをならす
;回想から戻ってきた時に音量が小さい時があるので音量設定
[bgmopt volume=80]
[playbgm2 loop="true" storage="piano3_001"]
[freeimage layer="0" page="back"]
[position page=fore layer=message1 frame="" left=0 top=0 width=8 height=8 visible=false]
[position page=fore layer=message0 frame="" opacity=0 left=0 top=0 width=800 height=600 marginT=0 marginL=0 marginR=0 marginB=0 visible=false]
[current page=fore layer=message0]
[jump storage="replay.ks"]
[endif]

*titleloop

[stoptrans]
;回想から帰ってくるとメッセージレイヤが変になってることがあるから初期化しておく
[position layer="message0" visible="false" page="back"]
[position layer="message1" visible="false" page="back"]
[trans method=crossfade time=250]
[wt]
[laycount messages=0]
[laycount messages=5]
[backlay]
[position page=back layer=message1 frame="" left=0 top=0 width=800 height=600 visible=false]
[position page=back layer=message0 frame="" opacity=0 left=0 top=0 width=800 height=600 marginT=0 marginL=0 marginR=0 marginB=0 visible=true]
[image layer=stage page=back storage="title"  visible=true left=0 top=0]

;显示汉化版本号
[eval exp="tf.ver1=sf.zohar_ver\100"]
[eval exp="tf.ver2=sf.zohar_ver\10%10"]
[eval exp="tf.ver3=sf.zohar_ver%10"]
[eval exp="tf.verbit=17, tf.verx=619, tf.very=275, tf.verjian=9"]
[pimage layer=stage page=back storage="num" visible=true dx=&tf.verx dy=&tf.very sx=&(tf.ver1*24) sy=0 sw=24 sh=32]
[pimage layer=stage page=back storage="num" visible=true dx=&(tf.verx+tf.verbit*2-tf.verjian) dy=&tf.very sx=&(10*24) sy=0 sw=24 sh=32]
[pimage layer=stage page=back storage="num" visible=true dx=&(tf.verx+tf.verbit*3-tf.verjian*2) dy=&tf.very sx=&(tf.ver2*24) sy=0 sw=24 sh=32]
[pimage layer=stage page=back storage="num" visible=true dx=&(tf.verx+tf.verbit*4-tf.verjian*2) dy=&tf.very sx=&(tf.ver3*24) sy=0 sw=24 sh=32]

[current page=back layer=message0]

; ボタンの配置
;選択バー読み込み
[iscript]

function onTitleBtnEnter(x, y)
{
	opanum = 3;
	pushbar.setPos(x, y);
	pushbar.opacity = 255;
	pushbar.visible = true;
}
function onTitleBtnLeave()
{
	pushbar.visible = false;
}
function onLoadFromTitle()
{
}
[endscript]
[image storage="title_selectbar" layer=1 page=back visible=false top=272 left=239]
[eval exp="var pushbar = kag.back.layers[1]"]

;つづきから
[locate x=307 y=300]
[button normal="title_tuduki" over="title_tuduki" storage=load.ks target=*startFromTitle onenter="onTitleBtnEnter(272, 308)" onleave="onTitleBtnLeave()" clickse="pi47"]
;はじめから
[locate x=310 y=340]
[button graphic="tit_hajime"target=*gamestart onenter="onTitleBtnEnter(272, 348)" onleave="onTitleBtnLeave()" clickse="jingle_001"]

;[locate x=254 y=336]
;[button name="start" target=*gamestart]
;[locate x=254 y=386]
;[button name="continue" storage=load.ks target=*startFromTitle]

;クリアフラグで表示を変更
;[locate x=254 y=436]
[locate x=314 y=376]
[if exp="sf.clear || tf.allseen"]
;Gallery
[button graphic="tit_gallery" target=*extra onenter="onTitleBtnEnter(272, 385)" onleave="onTitleBtnLeave()" clickse="pi47"]
;[button name="extra" target=*extra]
;[else]
;[button graphic="tit_gallery" disabled]
[endif]

;キャラクター
[locate x=307 y=416]
[button graphic="tit_char" storage=character.ks target=*startFromTitle onenter="onTitleBtnEnter(272, 424)" onleave="onTitleBtnLeave()" clickse="pi47"]


;オプション
[locate x=313 y=454]
[button graphic="tit_option" storage=config.ks  target=*startFromTitle onenter="onTitleBtnEnter(272, 463)" onleave="onTitleBtnLeave()" clickse="pi47"]
;[locate x=254 y=486]
;[button name="config" storage=config.ks  target=*startFromTitle]

;ルート開放設定
;[locate x=307 y=494]
;[button graphic="tit_root" storage=root.ks target=*startFromTitle onenter="onTitleBtnEnter(272, 502)" onleave="onTitleBtnLeave()" clickse="pi47"]

[locate x=315 y=533]
[button graphic="tit_exit" exp='kag.close()' onenter="onTitleBtnEnter(272, 541)" onleave="onTitleBtnLeave()"]
;[locate x=254 y=560]
;[button name="exit" exp='kag.close()']

;デバッグモード画面のリンク
[if exp=kag.debugMenu.visible]
[locate x=605 y=487]
[button name="でばっぐ" storage=debugmenu.ks  target=*start onleave="onTitleBtnLeave()"]
[endif]

[trans method=crossfade time=300]
[wt]
[current layer=message0 page=fore]
;BGMをならす
[playbgm2 loop="true" storage="piano3_001"]
[s]

*extra
[jump storage="musicmode.ks" cond='tf.extramode == 3']
[jump storage="replay.ks"    cond='tf.extramode == 2']
[jump storage="cgmode.ks"]

*backtotitle
[rclick enabled=false]
[stoprecollection]
[jump target=*titleloop]

*gamestart
[stoptrans]
[clearlayers page=back]
[trans method=crossfade time=500]
[wt]
[rclick enabled=true]
[jump storage=initname.ks]