; 
; キャラクター紹介画面
;

; 右クリックメニューからの呼び出し
*startFromMenu
[rclick enabled=true jump=true storage="" target=*backtomenu]
[eval exp='tf.fromTitle = 0']
[eval exp="tf.selcharback = f.selopchr"]
[eval exp="tf.table = f.encountSubChar"]
[jump target="*init_character"]

; ゲーム中からの呼び出し
*startFromGame
[rclick enabled=true jump=true storage="" target=*backtogame]
[eval exp='tf.fromTitle = 0']
[history enabled=false]
[eval exp="tf.selcharback = f.selopchr"]
[eval exp="tf.table = f.encountSubChar"]
[jump target=*init_character]

; タイトルからの呼び出し
*startFromTitle
;必要変数の初期化
;初期に選択されているキャラは設定しない
[endfocuscharacter]
;システム変数の遭遇フラグをフラグ変数に移行
[eval exp="f.encountMainChar = sf.encountMainChar"]
[eval exp="f.encountSubChar = sf.encountSubChar"]
[eval exp="f.encountSubChar_tatsuki = sf.encountSubChar_tatsuki"]
[eval exp="f.encountSubChar_konosuke = sf.encountSubChar_konosuke"]
[eval exp="f.encountSubChar_shun = sf.encountSubChar_shun"]
[eval exp="f.encountSubChar_koya = sf.encountSubChar_koya"]
[eval exp="f.encountSubChar_juichi = sf.encountSubChar_juichi"]
[eval exp="f.encountSubChar_shin = sf.encountSubChar_shin"]
[eval exp="f.encountSubChar_sotaro = sf.encountSubChar_sotaro"]
[eval exp="f.encountSubChar_kyoji = sf.encountSubChar_kyoji"]
[eval exp="f.encountSubChar_torahiko = sf.encountSubChar_torahiko"]
[eval exp="f.selopchr = 0"]
[rclick enabled=true jump=true storage="" target=*backtotitle]
[eval exp='tf.fromTitle = 1']

*init_character
;charMainSub  : フォーカスされているキャラがメインorサブのフラグ
;lookAtChar   : フォーカスされているキャラが何番目のキャラか
[eval exp="tf.charMainSub = 0" cond="tf.charMainSub === void"]
[eval exp="tf.lookAtChar = 0" cond="tf.lookAtChar === void"]
[eval exp="f.encountMainChar = [0,0,0,0,0,0,0,0,0,0,0]" cond="f.encountMainChar === void"]
[eval exp="f.encountSubChar = [0,0,0,0,0,0,0]" cond="f.encountSubChar === void"]
[eval exp="sf.encountMainChar = [0,0,0,0,0,0,0,0,0,0,0]" cond="sf.encountMainChar === void"]
[eval exp="sf.encountSubChar = [0,0,0,0,0,0,0]" cond="sf.encountSubChar === void"]
[iscript]
function init_charval(ondisp){
if(tf.focusChar !== void && tf.focusChar !== 0 && ondisp === void)
	{
	if (tf.focusChar < 100){
		tf.charMainSub = 0;
		tf.lookAtChar = tf.focusChar;
	}else if (tf.focusChar < 1000){
		tf.charMainSub = 1;
		tf.lookAtChar = tf.focusChar % 100;
	}
}else{
		tf.charMainSub = ondisp;
		tf.lookAtChar = 0;
		//menubarmove(-318,0);
	}
}
[endscript]
[eval exp="init_charval()"]

[if exp="tf.charMainSub == 1"]
[jump target="*sub_buttons"]
[endif]

*main_buttons
; ベース画像読み込み
[backlay]
[position layer=message1 frame="char_main_back" left=0 top=0 width=800 height=600 marginT=0 marginL=0 marginR=0 marginB=0 visible=true  transparent=false page=back]
[current layer=message1 page=back]

; ボタンの配置

;メインキャラ表示ボタン
[locate x=16  y=108]
[button name="char_main" disabled]
;サブキャラ表示ボタン
[locate x=141  y=108]
[button name="char_sub" clickse="pi47" target="*sub_buttons" exp="init_charval(1)"]

;メインキャラクタ
[locate x=5  y=144]
[if exp="f.encountMainChar[1]"]
[button name="char_c1" target="*main_buttons" clickse="pi47" enterse="click_008" exp='tf.lookAtChar = 1']
[else]
[button name="char_m_empty" disabled]
[endif]

[locate x=5  y=179]
[if exp="f.encountMainChar[2]"]
[button name="char_c2" target="*main_buttons" clickse="pi47" enterse="click_008" exp='tf.lookAtChar = 2']
[else]
[button name="char_m_empty" disabled]
[endif]

[locate x=5  y=214]
[if exp="f.encountMainChar[3]"]
[button name="char_c3" target="*main_buttons" clickse="pi47" enterse="click_008" exp='tf.lookAtChar = 3']
[else]
[button name="char_m_empty" disabled]
[endif]

[locate x=5  y=249]
[if exp="f.encountMainChar[4]"]
[button name="char_c4" target="*main_buttons" clickse="pi47" enterse="click_008" exp='tf.lookAtChar = 4']
[else]
[button name="char_m_empty" disabled]
[endif]

[locate x=5  y=284]
[if exp="f.encountMainChar[5]"]
[button name="char_c5" target="*main_buttons" clickse="pi47" enterse="click_008" exp='tf.lookAtChar = 5']
[else]
[button name="char_m_empty" disabled]
[endif]

[locate x=5  y=320]
[if exp="f.encountMainChar[6]"]
[button name="char_c6" target="*main_buttons" clickse="pi47" enterse="click_008" exp='tf.lookAtChar = 6']
[else]
[button name="char_m_empty" disabled]
[endif]

[locate x=5  y=354]
[if exp="f.encountMainChar[7]"]
[button name="char_c7" target="*main_buttons" clickse="pi47" enterse="click_008" exp='tf.lookAtChar = 7']
[else]
[button name="char_m_empty" disabled]
[endif]

[locate x=5  y=390]
[if exp="f.encountMainChar[8]"]
[button name="char_c8" target="*main_buttons" clickse="pi47" enterse="click_008" exp='tf.lookAtChar = 8']
[else]
[button name="char_m_empty" disabled]
[endif]

[locate x=5  y=426]
[if exp="f.encountMainChar[9]"]
[button name="char_c9" target="*main_buttons" clickse="pi47" enterse="click_008" exp='tf.lookAtChar = 9']
[else]
[button name="char_m_empty" disabled]
[endif]
[jump target="*drawcharacter"]

*sub_buttons
; ベース画像読み込み
[backlay]
[position layer=message1 frame="char_sub_back" left=0 top=0 width=800 height=600 marginT=0 marginL=0 marginR=0 marginB=0 visible=true  transparent=false page=back]
[current layer=message1 page=back]

;メインキャラ表示ボタン
[locate x=16  y=108]
[button name="char_main" clickse="pi47" target="*main_buttons" exp="init_charval(0)"]
;サブキャラ表示ボタン
[locate x=141  y=108]
[button name="char_sub" disabled]

[if exp="f.selopchr == 0 || f.encountSubChar === void"]
[locate x=5  y=284]
[button name="char_none" disabled]
[eval exp="tf.lookAtChar = 0"]
[jump target="*drawcharacter"]
[endif]

;サブキャラクタ
[locate x=5  y=144]
[if exp="f.encountSubChar[1]"]
[button name="&('char_' + f.selopchr + '_s1')" target="*sub_buttons" clickse="pi47" enterse="click_008" exp='tf.lookAtChar = 1']
[elsif exp="f.encountSubChar[1] !== void"]
[button name="char_s_empty" disabled]
[endif]

[locate x=5  y=179]
[if exp="f.encountSubChar[2]"]
[button name="&('char_' + f.selopchr + '_s2')" target="*sub_buttons" clickse="pi47" enterse="click_008" exp='tf.lookAtChar = 2']
[elsif exp="f.encountSubChar[2] !== void"]
[button name="char_s_empty" disabled]
[endif]

[locate x=5  y=214]
[if exp="f.encountSubChar[3]"]
[button name="&('char_' + f.selopchr + '_s3')" target="*sub_buttons" clickse="pi47" enterse="click_008" exp='tf.lookAtChar = 3']
[elsif exp="f.encountSubChar[3] !== void"]
[button name="char_s_empty" disabled]
[endif]

[locate x=5  y=249]
[if exp="f.encountSubChar[4]"]
[button name="&('char_' + f.selopchr + '_s4')" target="*sub_buttons" clickse="pi47" enterse="click_008" exp='tf.lookAtChar = 4']
[elsif exp="f.encountSubChar[4] !== void"]
[button name="char_s_empty" disabled]
[endif]

[locate x=5  y=284]
[if exp="f.encountSubChar[5]"]
[button name="&('char_' + f.selopchr + '_s5')" target="*sub_buttons" clickse="pi47" enterse="click_008" exp='tf.lookAtChar = 5']
[elsif exp="f.encountSubChar[5] !== void"]
[button name="char_s_empty" disabled]
[endif]

[locate x=5  y=320]
[if exp="f.encountSubChar[6]"]
[button name="&('char_' + f.selopchr + '_s6')" target="*sub_buttons" clickse="pi47" enterse="click_008" exp='tf.lookAtChar = 6']
[elsif exp="f.encountSubChar[6] !== void"]
[button name="char_s_empty" disabled]
[endif]

[locate x=5  y=354]
[if exp="f.encountSubChar[7]"]
[button name="&('char_' + f.selopchr + '_s7')" target="*sub_buttons" clickse="pi47" enterse="click_008" exp='tf.lookAtChar = 7']
[elsif exp="f.encountSubChar[7] !== void"]
[button name="char_s_empty" disabled]
[endif]

[locate x=5  y=390]
[if exp="f.encountSubChar[8]"]
[button name="&('char_' + f.selopchr + '_s8')" target="*sub_buttons" clickse="pi47" enterse="click_008" exp='tf.lookAtChar = 8']
[elsif exp="f.encountSubChar[8] !== void"]
[button name="char_s_empty" disabled]
[endif]

[locate x=5  y=426]
[if exp="f.encountSubChar[9]"]
[button name="&('char_' + f.selopchr + '_s9')" target="*sub_buttons" clickse="pi47" enterse="click_008" exp='tf.lookAtChar = 9']
[elsif exp="f.encountSubChar[9] !== void"]
[button name="char_s_empty" disabled]
[endif]

*drawcharacter
;戻るボタン
[if exp="tf.fromTitle"]
[locate x=131 y=467]
[button name="char_return" target=*backtotitle]
[else]
[locate x=131 y=467]
[button name="char_return" target=*backtogame]
[endif]

;キャラクター説明描画処理

;メインキャラ表示
[if exp="tf.charMainSub == 0"]
[position layer=message3 frame="&('char_m_' + tf.lookAtChar + '_back')" left=237 top=26 width=563 height=572 marginT=0 marginL=10 marginR=0 marginB=0 visible=true  transparent=false page=back]
[current layer="message3" page="back"]
[eval exp="kag.current.edgeEmphasis=5048"]
[eval exp="kag.current.edgeExtent=2"]
[font face=umefont17][mappfont storage="umefont17.tft"]
[deffont face="umefont17" size=17 bold="false" color="0xFFFFFF" edge="true" edgecolor="0x000000" shadow="false"]
;メインキャラ説明文ファイルへ
[er]
[call storage="mainchar.ks" target="*charainrto" cond="tf.lookAtChar != 0"]
;サブキャラテーブル変更ボタン
[iscript]
function sub_table_change(){
	switch(tf.lookAtChar){
		case 1:
			//孝之助
			f.selopchr=2;
			f.encountSubChar = f.encountSubChar_konosuke;
			break;

		case 2:
			//辰樹
			f.selopchr=1;
			f.encountSubChar = f.encountSubChar_tatsuki;
			break;

		case 3:
			//洸哉
			f.selopchr=4;
			f.encountSubChar = f.encountSubChar_koya;
			break;

		case 4:
			//虎彦
			f.selopchr=9;
			f.encountSubChar = f.encountSubChar_torahiko;
			break;

		case 5:
			//深
			f.selopchr=6;
			f.encountSubChar = f.encountSubChar_shin;
			break;

		case 6:
			//峻
			f.selopchr=3;
			f.encountSubChar = f.encountSubChar_shun;
			break;

		case 7:
			//京慈
			f.selopchr=8;
			f.encountSubChar = f.encountSubChar_kyoji;
			break;

		case 8:
			//宗太郎
			f.selopchr=7;
			f.encountSubChar = f.encountSubChar_sotaro;
			break;

		case 9:
			//柔一
			f.selopchr=5;
			f.encountSubChar = f.encountSubChar_juichi;
			break;
	}
}

[endscript]
[locate x=340 y=520]
[button name="char_tran" target="*sub_buttons" exp=" sub_table_change(), init_charval(1)" cond="tf.lookAtChar != 0"]



;サブキャラ表示
[elsif exp="tf.charMainSub == 1"]
[current layer="message3" page="back"]
[position layer=message3 frame="&('char_s_'+ f.selopchr +'_' + tf.lookAtChar + '_back')" left=237 top=26 width=563 height=572 marginT=0 marginL=10 marginR=0 marginB=0 visible=true  transparent=false page=back]
[eval exp="kag.current.edgeEmphasis=5048"]
[eval exp="kag.current.edgeExtent=2"]
[font face=umefont17][mappfont storage="umefont17.tft"]
[deffont face="umefont17" size=17 bold="false" color="0xFFFFFF" edge="true" edgecolor="0x000000" shadow="false"]
;サブキャラ説明文ファイルへ
[call storage="subchar.ks" target="*charainrto" cond="tf.lookAtChar != 0"]
[endif]
[mappfont storage="umefont.tft"]

[if exp="tf.lookAtChar >= 0"]
[trans method="universal" rule="menu_trans" vague="20" time=250]
[wt]
[current layer=message1 page=fore]
[eval exp="tf.focusChar=0"]
[elsif exp="tf.showMenu"]
[trans method="universal" rule="左上から右下へ" vague="10" time=150]
[wt]
[current layer=message1 page=fore]
[else]
[trans method=crossfade time=300]
[wt]
[current layer=message1 page=fore]
[endif]
[s]

*backtogame
[if exp="tf.showMenu"]
[jump target="*backtomenu"]
[else]
[rclick call=true storage="rclick.ks" target="*rclick" enabled=true]
[stoptrans]
[backlay]
[position layer=message1 page=back visible=false frame="" left=0 top=0 width=8 height=8]
[trans method=crossfade time=300]
[wt]
[current layer=message0]
[history enabled=true]
[jump target="*endchar"]
[endif]

*backtomenu
[rclick jump=false]
[stoptrans]
[rclick jump=true storage="rclick.ks" target="*exit" enabled=true]
[stoptrans]
[stopaction layer="1"]
[move layer=&tf.lay.menubar page="fore" path="(-218,108,255)" time=50 accel="2.0"]
[move layer=&tf.lay.menubar page="back" path="(-218,108,255)" time=50 accel="2.0"][wm]
[backlay]
[position layer=message3 page=back visible=false frame="" left=0 top=0 width=8 height=8]
[position layer=message1 page=back visible=false frame="" left=0 top=0 width=8 height=8]
[trans method="universal" rule="右下から左上へ" vague="10" time=150]
[wt]
[current layer=message4 page=fore]
[if exp="tf.selcharback !== void"]
[eval exp="f.selopchr = tf.selcharback"]
[eval exp="f.encountSubChar = tf.table"]
[endif]

*endchar
[return]

*backtotitle
[rclick enabled=false jump=false]
[current layer=message0]
[jump storage="title.ks" target=*backtotitle]