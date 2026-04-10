;------------------------------------------------------------------------------------
;漏れなつ。
;logo.ks ロゴ表示のの処理です。
;(c)2006 漏れなつ。プロジェクト
;------------------------------------------------------------------------------------

*logo|

[cancelskip]
[rclick enabled=false]
[clickskip enabled=true]
[position layer=message0 frame="" opacity=0 left=0 top=0 width=800 height=600 marginT=0 marginL=0 marginR=0 marginB=0 visible=true]

[beginskip]
;注意書き表示
[begintrans]
[newlay name=logo file=staffCN level=6 xpos=0 ypos=0]
[endtrans trans=normal time=1000]
[wait time=5000]
[begintrans]
[hideall]
[endtrans trans=normal time=1000]
;ロゴムービー再生

;windows vista以降は動画再生モードをmixerにそれ以外はオーバレイ表示
[iscript]
// 現在のWindowsのバージョン
property currentWindowsVersion { getter {
	var m = (new RegExp("^Windows [^\\s]+ (\\d+\\.\\d+)", "i")).match(System.osName);
	var ver = (m.count > 0) ? +m[1] : 0;
	&global.currentWindowsVersion = ver;
	dm("currentWindowsVersion", ver);
	return ver;
} }
[endscript]
[if exp="global.currentWindowsVersion >= 6"]
[video height=600 width=800 left=0 top=0 visible="true" mode="mixer"]
[else]
[video height=600 width=800 left=0 top=0 visible="true"]
[endif]
;動画再生モード設定終わり
[openvideo storage="opp.avi"]
[playvideo]
[video volume="&kag.bgmvolume"]
[wv canskip="true"]
[video visible="false" ]
[endskip]

@return

