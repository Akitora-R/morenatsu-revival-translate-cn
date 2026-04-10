;
;ルート変更

;
*startFromTitle|デバッグメニュー

[rclick enabled=true jump=true storage="" target=*backtotitle]
;メッセージをログに記録しない
[history output=false]

; ベース画像読み込み
*setbutton
[backlay]
[hideyesno]
[position layer=message1 frame="日付背景" left=0 top=0 width=800 height=600 marginT=0 marginL=0 marginR=0 marginB=0 visible=true  transparent=false page=back]
[current layer=message1 page=back]


; ボタンの配置
[nowait]　　ScenarioのEnd Flag、及びGalleryを[r]
　　開放したいキャラを選択してください[r]
　　右键单击返回标题画面。


[iscript]
function charClear(charnum, flags){
	switch(charnum){
		case 1:
			//孝之助
			sf.kounosuke_clear = flags;
			sf.kounosuke_clear2 = flags;
			if(flags){
				sf.encountSubChar_konosuke = [0,1,1,1,1,0,0,0,0,0];
				sf.clear = true;
				sf['cg_EV_KOUNOSUKE_1'] = true;
				sf['cg_EV_KOUNOSUKE_2'] = true;
				sf['cg_七つ目の秘密1'] = true;
				sf['cg_七つ目の秘密2'] = true;
				sf['cg_七つ目の秘密3'] = true;
				sf['cg_あとがき_ルーオゥ1'] = true;
				sf['cg_あとがき_ルーオゥ2'] = true;
				sf['trail_孝之助_m_08_恋人の証'] = 1;
				sf['trail_孝之助_s_01_孝之助、おまけ'] = 1;
			}else{
				sf.encountSubChar_konosuke = [0,0,0,0,0,0,0,0,0,0];
				sf['cg_EV_KOUNOSUKE_1'] = false;
				sf['cg_EV_KOUNOSUKE_2'] = false;
				sf['cg_七つ目の秘密1'] = false;
				sf['cg_七つ目の秘密2'] = false;
				sf['cg_七つ目の秘密3'] = false;
				sf['cg_あとがき_ルーオゥ1'] = false;
				sf['cg_あとがき_ルーオゥ2'] = false;
				sf['trail_孝之助_m_08_恋人の証'] = 0;
				sf['trail_孝之助_s_01_孝之助、おまけ'] = 0;
			}
			break;

		case 2:
			//辰樹
			sf.tatuki_clear = flags;
			if(flags){
				sf.encountSubChar_tatsuki = [0,1,1,1,1,1,1,1,0,0];
				sf.clear = true;
				sf['cg_EV_TATSUKI_1'] = true;
				sf['cg_EV_TATSUKI_2'] = true;
				sf['cg_あとがき_ウメ1'] = true;
				sf['cg_あとがき_ウメ2'] = true;
				sf['trail_辰樹_m_n_ero1'] = 1;
				sf['trail_辰樹_m_09_ameteorshower'] = 1;
			}else{
				sf.encountSubChar_tatsuki = [0,0,0,0,0,0,0,0,0,0];
				sf['cg_EV_TATSUKI_1'] = false;
				sf['cg_EV_TATSUKI_2'] = false;
				sf['cg_あとがき_ウメ1'] = false;
				sf['cg_あとがき_ウメ2'] = false;
				sf['trail_辰樹_m_n_ero1'] = 0;
				sf['trail_辰樹_m_09_ameteorshower'] = 0;
			}
			break;

		case 3:
			//洸哉
			sf.kouya_clear = flags;
			if(flags){
				sf.encountSubChar_koya = [0,1,1,1,1,1,0,0,0,0];
				sf.clear = true;
				sf['cg_EV_KOUYA_1'] = true;
				sf['cg_EV_KOUYA_1B'] = true;
				sf['cg_EV_KOUYA_2'] = true;
				sf['cg_EV_KOUYA_2B'] = true;
				sf['cg_あとがき_雪だるま'] = true;
				sf['trail_洸哉_m_05_heart'] = 1;
				sf['trail_洸哉_m_08_i_think'] = 1;
			}else{
				sf.encountSubChar_koya = [0,0,0,0,0,0,0,0,0,0];
				sf.clear = true;
				sf['cg_EV_KOUYA_1'] = false;
				sf['cg_EV_KOUYA_1B'] = false;
				sf['cg_EV_KOUYA_2'] = false;
				sf['cg_EV_KOUYA_2B'] = false;
				sf['cg_あとがき_雪だるま'] = false;
				sf['trail_洸哉_m_05_heart'] = 0;
				sf['trail_洸哉_m_08_i_think'] = 0;
			}
			break;

		case 4:
			//虎彦
			f.selopchr=9;
			f.encountSubChar = f.encountSubChar_torahiko;
			break;

		case 5:
			//深
			sf.shin_clear = flags;
			if(flags){
				sf.encountSubChar_shin = [0,1,0,0,0,0,0,0,0,0];
				sf.clear = true;
				sf['cg_EV_SHIN_1'] = true;
				sf['cg_EV_SHIN_1B'] = true;
				sf['cg_EV_SHIN_2'] = true;
				sf['cg_EV_SHIN_2B'] = true;
				sf['cg_あとがき_ルーオゥ3'] = true;
				sf['cg_あとがき_ルーオゥ4'] = true;
				sf['trail_深_m_08_キミが、好き'] = 1;
			}else{
				sf.encountSubChar_shin = [0,0,0,0,0,0,0,0,0,0];
				sf['cg_EV_SHIN_1'] = false;
				sf['cg_EV_SHIN_1B'] = false;
				sf['cg_EV_SHIN_2'] = false;
				sf['cg_EV_SHIN_2B'] = false;
				sf['cg_あとがき_ルーオゥ3'] = false;
				sf['cg_あとがき_ルーオゥ4'] = false;
				sf['trail_深_m_08_キミが、好き'] = 0;
			}
			break;

		case 6:
			//峻
			sf.shun_clear = flags;
			if(flags){
				sf.encountSubChar_shun = [0,1,1,0,0,0,0,0,0,0];
				sf.clear = true;
				sf['cg_EV_SHUN_1'] = true;
				sf['cg_EV_SHUN_1B'] = true;
				sf['cg_EV_SHUN_2'] = true;
				sf['cg_EV_SHUN_2B'] = true;
				sf['cg_あとがき_ひゅがくぉ'] = true;
				sf['trail_峻_m_03_shunmain03-06'] = 1;
				sf['trail_峻_m_05_shunmain05-06'] = 1;
			}else{
				sf.encountSubChar_shun = [0,0,0,0,0,0,0,0,0,0];
				sf['cg_EV_SHUN_1'] = false;
				sf['cg_EV_SHUN_1B'] = false;
				sf['cg_EV_SHUN_2'] = false;
				sf['cg_EV_SHUN_2B'] = false;
				sf['cg_あとがき_ひゅがくぉ'] = false;
				sf['trail_峻_m_03_shunmain03-06'] = 0;
				sf['trail_峻_m_05_shunmain05-06'] = 0;
			}
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
			sf.juichi_clear = flags;
			if(flags){
				sf.encountSubChar_juichi = [0,1,0,0,0,0,0,0,0,0];
				sf.clear = true;
				sf['cg_EV_JUICHI_1'] = true;
				sf['cg_EV_JUICHI_1B'] = true;
				sf['cg_EV_JUICHI_2'] = true;
				sf['cg_EV_JUICHI_2B'] = true;
				sf['cg_EV_JUICHI_2C'] = true;
				sf['cg_あとがき_イワーク'] = true;
				sf['trail_柔一_m_07_jm07_09'] = 1;
				sf['trail_柔一_m_08_sex01'] = 1;
			}else{
				sf['cg_EV_JUICHI_1'] = false;
				sf['cg_EV_JUICHI_1B'] = false;
				sf['cg_EV_JUICHI_2'] = false;
				sf['cg_EV_JUICHI_2B'] = false;
				sf['cg_EV_JUICHI_2C'] = false;
				sf['cg_あとがき_イワーク'] = false;
				sf['trail_柔一_m_07_jm07_09'] = 0;
				sf['trail_柔一_m_08_sex01'] = 0;
			}
			f.encountSubChar = f.encountSubChar_juichi;
			break;
	}
	
	if(sf.clear == true){
		sf['cg_あとがき_虎犬'] = 1;
		sf.numatogakinotice = 1;
		sf.numgalnotice = 1;
	}

}

[endscript]
;キャラクタの画像
;辰樹
[locate x=80 y=150]
[if exp="sf.tatuki_clear"]
[button name="tatsu" normal="micon_tatu"  clickse="pi47" target="*setbutton" exp="charClear(2,false)"]
[else]
[button name="tatsu" normal="micon_tatu2"  clickse="pi47" target="*setbutton" exp="charClear(2,true)"]
[endif]


;孝之助
[locate x=80 y=300]
[if exp="sf.kounosuke_clear2"]
[button name="kou" normal="micon_kou" clickse="pi47" target="*setbutton" exp="charClear(1,false)"]
[else]
[button name="kou" normal="micon_kou2" clickse="pi47" target="*setbutton" exp="charClear(1,true)"]
[endif]


;峻
[locate x=230 y=150]
[if exp="sf.shun_clear"]
[button name="shun" normal="micon_shun"  clickse="pi47" target="*setbutton" exp="charClear(6,false)"]
[else]
[button name="syun" normal="micon_shun2"  clickse="pi47" target="*setbutton" exp="charClear(6,true)"]
[endif]

;洸哉
[locate x=230 y=300]
[if exp="sf.kouya_clear"]
[button name="koya" normal="micon_koya"  clickse="pi47" target="*setbutton" exp="charClear(3,false)"]
[else]
[button name="koya" normal="micon_koya2"  clickse="pi47" target="*setbutton" exp="charClear(3,true)"]
[endif]

;柔一
[locate x=380 y=150]
[if exp="sf.juichi_clear"]
[button name="juichi" normal="micon_jyu"  clickse="pi47" target="*setbutton" exp="charClear(9,false)"]
[else]
[button name="juichi" normal="micon_jyu2"  clickse="pi47" target="*setbutton" exp="charClear(9,true)"]
[endif]


;深
[locate x=380 y=300]
[if exp="sf.shin_clear"]
[button name="shin" normal="micon_sin"  clickse="pi47" target="*setbutton" exp="charClear(5,false)"]
[else]
[button name="shin" normal="micon_sin2"  clickse="pi47" target="*setbutton" exp="charClear(5,true)"]
[endif]


;京慈
[locate x=530 y=150]
[button name="kyoji" normal="micon_kyou2"  clickse="pi47" disabled]

;宗太郎
[locate x=530 y=300]
[button name="sotaro" normal="micon_sou2"  clickse="pi47" disabled]

;虎彦
[locate x=80 y=450]
[button name="torahiko" normal="micon_tora2"  clickse="pi47" disabled]


[endnowait]
[trans method="universal" rule="左上から右下へ" vague="10" time=150]
[wt]
;メッセージをログに記録する
[history output=false]
[s]


*backtotitle
[rclick enabled=false jump=false]
[eval exp='configExit()']
[current layer=message0]
[jump storage="title.ks" target=*backtotitle]