@loadplugin module=wuvorbis.dll
@loadplugin module=extrans.dll
@loadplugin module=csvparser.dll
@call storage="world.ks"
@call storage="macro.ks"

; 選択肢配置領域の指定
[selopt left=0 top=0 width=800 height=420 normal=select_n_tora over=select_a_tora clickse="on03" enterse="click_008" fadeTime="500" font="ＭＳ Ｐゴシック" bold="false" color="0xFFFFFF" edge="true" edgecolor="0x000000" shadow="false"]

[iscript]

// 全部見たことにするフラグ XXX 最終的に削除すること!!!
//tf.allseen = true;

// クリアフラグ強制ON XXX 最終的に削除すること!!!
//sf.clear = true;

// バージョン
sf.software_version = "3.5";

// メーカー
sf.software_maker = "漏れなつ。プロジェクト";

// ソフト名
sf.software_title = "漏れなつ。";

// 年
sf.software_year = "2013";

// 汉化版本
sf.zohar_ver = 150;

// ロード対象ページ
sf.loadpage = 1 if sf.loadpage === void;

/**
 * 環境設定初期化処理
 */
function initialEnvironment()
{
    kag.noeffect     = false;
    kag.textspeed    = kag.chSpeeds.normal / (kag.chSpeeds.slow / 10);
    kag.autospeed    = kag.autoModePageWaits.medium / (kag.autoModePageWaits.slow / 10);
    kag.allskip      = false;
    kag.bgmvolume    = 80;
    kag.sevolume     = 100;
    kag.voicevolume  = 100;
    
    //ボイスなし
    /*kag.setVoiceOn('voice0', true);
    kag.setVoiceOn('voice1', true);
    kag.setVoiceOn('voice2', true);
    kag.setVoiceOn('voice3', true);
    kag.setVoiceOn('voice4', true);
    kag.setVoiceOn('voice5', true);*/
}

// 初回起動時は環境を初期化する
if (sf.first_start != 'comp') {
    initialEnvironment();
//キャラ紹介用のテーブル初期化(タイトル用)
	sf.encountMainChar = [0,1,1,1,1,1,1,1,1,1,1];
	sf.encountSubChar = [0,0,0,0,0,0,0,0,0,0,0];
	sf.encountSubChar_tatsuki = [0,0,0,0,0,0,0,0,0,0,0];
	sf.encountSubChar_konosuke = [0,0,0,0,0,0,0,0,0,0,0];
	sf.encountSubChar_shun = [0,0,0,0,0,0,0,0,0,0,0];
	sf.encountSubChar_koya = [0,0,0,0,0,0,0,0,0,0,0];
	sf.encountSubChar_juichi = [0,0,0,0,0,0,0,0,0,0,0];
	sf.encountSubChar_shin = [0,0,0,0,0,0,0,0,0,0,0];
	sf.encountSubChar_sotaro = [0,0,0,0,0,0,0,0,0,0,0];
	sf.encountSubChar_kyoji = [0,0,0,0,0,0,0,0,0,0,0];
	sf.encountSubChar_torahiko = [0,0,0,0,0,0,0,0,0,0,0];

    sf.first_start = 'comp';
}

[endscript]
[rclick enabled="true"]
[call storage="logo.ks" target="*logo"]
[jump storage=title.ks]