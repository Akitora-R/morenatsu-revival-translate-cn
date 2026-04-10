;------------------------------------------------------------------------------------
;楻傟側偮丅
;logo.ks 儘僑昞帵偺偺張棟偱偡丅
;(c)2006 楻傟側偮丅僾儘僕僃僋僩
;------------------------------------------------------------------------------------

*logo|

[cancelskip]
[rclick enabled=false]
[clickskip enabled=true]
[position layer=message0 frame="" opacity=0 left=0 top=0 width=800 height=600 marginT=0 marginL=0 marginR=0 marginB=0 visible=true]

[beginskip]
;拲堄彂偒昞帵
[begintrans]
[newlay name=logo file=staffCN level=6 xpos=0 ypos=0]
[endtrans trans=normal time=1000]
[wait time=5000]
[begintrans]
[hideall]
[endtrans trans=normal time=1000]
;儘僑儉乕價乕嵞惗

;windows vista埲崀偼摦夋嵞惗儌乕僪傪mixer偵偦傟埲奜偼僆乕僶儗僀昞帵
[iscript]
// 尰嵼偺Windows偺僶乕僕儑儞
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
;摦夋嵞惗儌乕僪愝掕廔傢傝
[openvideo storage="opp.avi"]
[playvideo]
[video volume="&kag.bgmvolume"]
[wv canskip="true"]
[video visible="false" ]
[endskip]

@return

