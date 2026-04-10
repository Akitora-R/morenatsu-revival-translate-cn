;------------------------------------------------------------------------------------
;漏れなつ。
;rclick.ks　　右クリックサブルーチンです。
;(c)2006 漏れなつ。プロジェクト
;------------------------------------------------------------------------------------

*rclick
[rclick jump=true storage="rclick.ks" target="*exit" enabled=true]
;セーブ用スナップショットをロックしておく
[locksnapshot]
;ログにメニューのメッセージが記録されないようにする
[history output="false" enabled="false"]
;クリッカマブルマップの無効化
[mapdisable layer="base" page="fore"]
;空白行の改ページ情報の保持
[iscript]
tf.tempAfterPage = kag.afterPage;
tf.tempEnptyLine = kag.emptyLine;
[endscript]

;現在のスナップショット画面をlayer0にコピーする
[iscript]
//メッセージレイヤ管理辞書
tf.mes = %[main:"message0",menu:"message1",pop:"message3",select:"message3",menu2:"message3"];
//レイヤー管理辞書
tf.lay = %[menubar:1];
//重い処理を無効にするか
tf.enah = true;
//今右クリックメニューを表示しているか？
tf.showMenu = true;
//選択肢は表示されているか？
tf.invisibleSelect = kag.selectLayer.visible;

kag.back.layers[0].setPos(0,0,kag.scWidth, kag.scHeight);
kag.fore.layers[0].setPos(0,0,kag.scWidth, kag.scHeight);
kag.fore.layers[0].setImageSize(kag.scWidth, kag.scHeight);
kag.back.layers[0].piledCopy(0, 0, kag.fore.base, 0, 0, kag.scWidth, kag.scHeight);
kag.fore.layers[0].piledCopy(0, 0, kag.fore.base, 0, 0, kag.scWidth, kag.scHeight);
kag.back.layers[0].type = ltOpaque;
kag.fore.layers[0].type = ltOpaque;
[endscript]

;メニューボタンにマウスが侵入したときメニューバーを動かすための関数
[iscript]
function menubarmove(xn,yn,t=1350)
{
kag.tagHandlers.stopaction(%[layer : (string)tf.lay.menubar]);
if (!tf.enah){
	t = 0;
	}
kag.tagHandlers.action(%[layer : (string)tf.lay.menubar,module : LayerSpringMoveModule,time : t,x : xn,y : yn]);
}

function menubarmoveclick()
{
stop();
kag.tagHandlers.stopmove();
var tlayer = kag.fore.layers[tf.lay.menubar];
startSplingsimu(tlayer,tlayer.left+80,tlayer.top,tlayer.left,tlayer.top,3000,300.0,500.0,0.0,0.0);
}

 
//メニューのデジタル時計
function onTimer()
{
	var time2;
	try{
	time2 = kag.playTime + (new Date()).getTime() - kag.playStartTime;
	}catch{
	//なんか終了するときにエラーが出るみたい
	dm("プレイタイムを取得できませんでした");
	}
	var h = (int)(time2/3600000); // 時
	var m = (int)((time2/60000)%60); // 分
	var s = (int)((time2/1000)%60); // 秒
	
  	// デジタル
	clock.fillRect(0, 0, 200, 30, 0x00ffffff);
	var text;
	if(tf.recollect){
		text = "Replay Mode...";
	}else{
		text = "Play time：" + "%02d：".sprintf(h) + "%02d：".sprintf(m) + "%02d".sprintf(s);
	}
	
	var savedatatitle = kag.currentPageName;
	savedatatitle = savedatatitle.substring(0,25);
	clock.font.height = 20;
	clock.drawText(5, 5, text, 0xffffff, 255, true , 5048 ,0x000000,3 ,0,0);
	clock.font.height = 30;
	clock.drawText(5, 30, "8月"+ ((kag.bookMarkInfo.date !== void) ? kag.bookMarkInfo.date : "？") + "日" + ":" +savedatatitle, 0xffffff, 255, true , 5048 ,0x000000,3 ,0,0);
}

clock = new ActionLayer(kag, kag.fore.base);
clock.setSize(800, 70);
clock.setPos(10,520);
clock.opacity = 0;
clock.hitThreshold = 256;

// タイマーを作成
timer = new Timer(onTimer, '');
timer.interval = 500;

function showClock()
{
onTimer(); // 一回呼んでおく
clock.parent = kag.fore.base;
clock.visible = true;
clock.beginAction(LayerFadeToModeModule,%["opacity" => 255,"time" => 1500]);
timer.enabled = true;
}

function hideClock()
{
clock.beginAction(LayerFadeToModeModule,%["opacity" => 0,"time" => 90]);
}

function destClock()
{
	invalidate timer;
	invalidate clock;
}
[endscript]

;メニューウインドウ表示
[position layer="message4" top="26" left="-234" height="253" width="234" frame="menu" marginb="0" marginl="0" marginr="0" margint="0" visible="true"]
[laylevel layer=&tf.lay.menubar level=100]
[eval exp="kag.fore.layers[0].absolute = kag.fore.messages[0].absolute + 100;"]
;ボタンの描画
[current layer="message4" page="fore"]
[nowait]
[er]

[if exp="tf.recollect"]
[locate x=8 y=11]
[button normal="menu_save_disable" disabled]
[else]
[locate x=46 y=11]
[button graphic="menu_save" target="*m_save" onenter="menubarmove(6,37)" enterse="click_008" clickse="pi47"]
[endif]
[if exp="tf.recollect"]
[locate x=8 y=58]
[button normal="menu_load_disable" disabled]
[else]
[locate x=51 y=58]
[button normal="menu_load" target="*m_load" onenter="menubarmove(6,83)" enterse="click_008" clickse="pi47"]
[endif]
[locate x=9 y=102]
[button graphic="menu_totitle" exp="gotoTitle()" onenter="menubarmove(6,129)" enterse="click_008" clickse="pi47"]
[locate x=12 y=146]
[button graphic="menu_config" target="*m_config" onenter="menubarmove(6,174)" enterse="click_008" clickse="pi47"]
[locate x=9 y=192]
[if exp="tf.focusChar > 0"]
[button graphic="menu_char_new" target="*m_character" onenter="menubarmove(6,218)" enterse="click_008" clickse="pi47"]
[else]
[button graphic="menu_char" target="*m_character" onenter="menubarmove(6,218)" enterse="click_008" clickse="pi47"]
[endif]
[locate x=52 y=237]
[button graphic="menu_return" target="*exit" onenter="menubarmove(6,265)" enterse="click_008"]
[endnowait]
[playse storage="button_018"]
;[laylevel layer="0" level="8"]
[layopt layer="0" visible="true"]

;すべての選択ボタンの無効化(隠す)
[if exp="tf.invisibleSelect"]
[eval exp="kag.selectLayer.visible = false"]
[endif]

;重い処理が無効の時は徐々にぼかし処理はしない
[if exp="tf.enah"]
[blur_start layer=0 l=20 dtl=5 dt=10][wblur]
[endif]
[if exp="!tf.enah"]
[blur_start layer=0 l=20 dtl=20 dt=60][wblur]
[endif]

;マップ選択肢の無効化
[iscript]
if(kag.mapSelectShowing === true){
kag.mapSelectLayer.setHiddenStateByUser(true);
}
[endscript]

[move layer="message4" page="fore" accel=-3 path="(-234,26,255)(0,26,255)" time="100"]
[eval exp="showClock()"]
[wm]

;メニュー前のゲーム状態の保存はしなくていいか
;[backlay][tempsave]

*menu
;メニューのselprosesslockの有効化
[eval exp="kag.fore.messages[4].setSelProcessLock(false)"]
[image layer=&tf.lay.menubar page="fore" storage="menu_select" visible="true" top=108 left=-218]

;メインメニュー画面を読み込んでおく
[position layer=&tf.mes.menu2 frame="menu_window" marginb="0" marginl="0" marginr="0" margint="0" visible="true" left="800" top="26" height="572" width="563"]
;[eval exp="startSplingsimu(kag.fore.layers[tf.lay.menubar],-108,-50,408,218,5000,10.0,30.0,0.0,0.0)"]
[s]

;セーブ画面の処理
*m_save
[eval exp="hideClock()"]
[move layer="message4" page="fore" accel=3 path="(0,26,255)(-234,26,255)" time="100"][wm]
[stopaction layer="1"]
[move layer=&tf.lay.menubar path="(-218,108,255)" time=50 accel="2.0"][wm]
[call storage="save.ks" target="*startFromMenu"]
[locklink]
[move layer="message4" page="fore" accel=-3 path="(-234,26,255)(0,26,255)" time="100"]
[eval exp="showClock()"]
[wm]
[current layer=&tf.mes.menu]
[jump target="*menu"]

;ロード画面の処理
*m_load
[eval exp="hideClock()"]
[move layer="message4" page="fore" accel=3 path="(0,26,255)(-234,26,255)" time="100"][wm]
[stopaction layer="1"]
[move layer=&tf.lay.menubar path="(-218,108,255)" time=50 accel="2.0"][wm]
[call storage="load.ks" target="*startFromMenu"]
[locklink]
[move layer="message4" page="fore" accel=-3 path="(-234,26,255)(0,26,255)" time="100"]
[eval exp="showClock()"]
[wm]
[current layer=&tf.mes.menu]
[jump target="*menu"]

;画面表示
*m_hyouji
[layopt layer="0" visible="false"]
[layopt layer=&tf.lay.menubar visible="false" top=108 left=-218]
[eval exp="hideClock()"]
[wait time="100" canskip="false"]
[hidemessage]
[eval exp="showClock()"]
[playse storage="push29" loop="false"]
[layopt layer="0" visible="true"]
[layopt layer=&tf.lay.menubar visible="true"]
[jump target="*menu"]

;コンフィグ画面へ
*m_config
[eval exp="hideClock()"]
[move layer="message4" page="fore" accel=3 path="(0,26,255)(-234,26,255)" time="100"][wm]
[stopaction layer="1"]
[move layer=&tf.lay.menubar path="(-218,108,255)" time=50 accel="2.0"][wm]
[call storage="config.ks" target="*startFromMenu"]
[locklink]
[move layer="message4" page="fore" accel=-3 path="(-234,26,255)(0,26,255)" time="100"]
[eval exp="showClock()"]
[wm]
[current layer=&tf.mes.menu]
[jump target="*menu"]

;キャラ紹介画面
*m_character
[eval exp="hideClock()"]
[move layer="message4" page="fore" accel=3 path="(0,26,255)(-234,26,255)" time="100"][wm]
[stopaction layer="1"]
[move layer=&tf.lay.menubar path="(-218,108,255)" time=50 accel="2.0"][wm]
[call storage="character.ks" target="*startFromMenu"]
[locklink]
[move layer="message4" page="fore" accel=-3 path="(-234,26,255)(0,26,255)" time="100"]
[eval exp="showClock()"]
[wm]
[current layer=&tf.mes.menu]
[jump target="*menu"]

;メニュを抜ける
*exit
[locklink]

[playse storage="push29" loop="false"]
[current layer="message0" page="fore"]
[stopaction layer="1"]
[move layer=&tf.lay.menubar path="(-218,108,255)" time=50 accel="2.0"][wm canskip="false"]
[move layer="message4" page="fore" accel=3 path="(0,26,255)(-234,26,255)" time="100"]
;時計を隠す
[eval exp="hideClock()"]
[wm]
[freeimage layer=&tf.lay.menubar]

;重い処理が無効の時は徐々にぼかし処理はしない
[if exp="tf.enah"]
[blur_start fadeout="true" l=20 dtl=5 dt=10][wblur]
[endif]
[if exp="!tf.enah"]
[blur_start fadeout="true" l=20 dtl=20 dt=60][wblur]
[endif]

[image layer="0" page="fore" visible="false" storage="toumei" opacity="255" top="0" left="0"]
[image layer="0" page="back" visible="false" storage="toumei" opacity="255" top="0" left="0"]

[position layer=&tf.mes.menu2 page="fore" visible="false"]
[rclick call=true storage="rclick.ks" target="*rclick" enabled=true]
[eval exp="tf.showMenu = false"]

;時計削除
[eval exp="destClock()"]
;選択肢を表示
[if exp="tf.invisibleSelect"]
[eval exp="kag.selectLayer.visible = true"]
[endif]

;マップ選択肢の有効化
[iscript]
if(kag.mapSelectShowing === true){
kag.mapSelectLayer.setHiddenStateByUser(false);
}
[endscript]
;空白行の改ページ情報を元に戻す
[iscript]
kag.afterPage = tf.tempAfterPage;
kag.emptyLine = tf.tempEnptyLine;
[endscript]
[history output="true" enabled="true"]
[unlocklink]
[unlocksnapshot]
[return]