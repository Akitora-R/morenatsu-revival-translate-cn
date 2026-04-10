
﻿[clearplaytime]
[clearvar]
;変数初期化
[eval exp="kag.noeffect = false"]
[eval exp=kag.addBookMarkInfo("date",00)]
[eval exp=kag.addBookMarkInfo("char","")]
[eval exp=f.mname="西村";]
[eval exp=f.fname="博行";]
[eval exp=f.fs="咱";]
[eval exp="f.selopchr=0"]
[eval exp="f.encountMainChar = [0,0,0,0,0,0,0,0,0,0,0]"]
[eval exp="f.encountSubChar = [0,0,0,0,0,0,0,0,0,0,0]"]

;それぞれのシナリオキャラ用にサブキャラのエンカウントテーブルを拡張。
;参照は元々のencountSubCharを通してみるようにする。
[eval exp="f.encountSubChar_tatsuki = [0,0,0,0,0,0,0,0,0,0,0]"]
[eval exp="f.encountSubChar_konosuke = [0,0,0,0,0,0,0,0,0,0,0]"]
[eval exp="f.encountSubChar_shun = [0,0,0,0,0,0,0,0,0,0,0]"]
[eval exp="f.encountSubChar_koya = [0,0,0,0,0,0,0,0,0,0,0]"]
[eval exp="f.encountSubChar_juichi = [0,0,0,0,0,0,0,0,0,0,0]"]
[eval exp="f.encountSubChar_shin = [0,0,0,0,0,0,0,0,0,0,0]"]
[eval exp="f.encountSubChar_sotaro = [0,0,0,0,0,0,0,0,0,0,0]"]
[eval exp="f.encountSubChar_kyoji = [0,0,0,0,0,0,0,0,0,0,0]"]
[eval exp="f.encountSubChar_torahiko = [0,0,0,0,0,0,0,0,0,0,0]"]


;[erafterpage mode="true"]
[rclick enabled="false"]
[暗転 trans=normal]

;キャラ好感度初期化
[eval exp="f.tatsuki_val=0"]
[eval exp="f.konosuke_val=0"]
[eval exp="f.shun_val=0"]
[eval exp="f.koya_val=0"]
[eval exp="f.juichi_val=0"]
[eval exp="f.shin_val=0"]
[eval exp="f.sotaro_val=0"]
[eval exp="f.kyoji_val=0"]
[eval exp="f.torahiko_val=0"]

;辰樹編のバイトフラグ
[eval exp="f.tatsuki_arbeit=0"]

;スキップ時にSEならさない
[eval exp="kag.nosewhenskip=true"]

[BGM play=piano_006 time=1000]

*inputname
[image layer="stage" storage="namein_back" page="back"]
[current layer="message0" page="back" withback="false"]
[eval exp="kag.current.edgeEmphasis=5048"]
[eval exp="kag.current.edgeExtent=2"]
[deffont face="umefont" bold="false" color="0xFFFFFF" edge="true" edgecolor="0x000000" shadow="false"]
[mappfont storage="umefont.tft"]
[nowait]
[position layer=message0 page=back visible=true]
[font size=35]
;名字
[locate x=215 y=277]
[edit maxchars=3 length=150 name="f.mname" opacity=122]
;名前
[locate x=463 y=277]
[edit maxchars=3 length=150 name="f.fname" opacity=122]
;一人称
[locate x=375 y=363]
[edit maxchars=3 length=150 name="f.fs" opacity=122]
[locate x=335 y=433]
[button normal=namein_ok_normal target="*confname" clickse=pi47]
[trans time=500 method=crossfade]
[wt canskip="false"]
*inputname2
[s]
*confname
[backlay]
[commit]
[if exp="f.mname.length==0 || f.fname.length==0 || f.fs.length==0"]
[infomation]
[r]
[style align="center"][font color="0xFC1003"]尚未输入任何字符。[resetfont]
[endinfomation target="*nameno" caution="true"]
[endif]
;文字数判定
[if exp="f.mname.length > 3 || f.fname.length > 3 || f.fs.length > 3"]
[infomation]
[style align="center"][font color="0xFC1003"]输入的字符数超出范围。[r][r]请控制在3个字符内。[resetfont]
[endinfomation target="*nameno" caution="true"]
[endif]
[yesno]
[style align="center"]你的名字叫「[font color="0xFF8040"][emb exp="f.mname"]　[emb exp="f.fname"][font color="default"]」[r]
自称叫「[font color="0xFF8040"][emb exp="f.fs"][font color="default"]」?
[endyesno notarget="*nameno" yestarget="*nameyes" yclickse="se_006"]
*nameno
[hideyesno]
[current layer="message0" page="back" withback="false"][unlocklink]
[jump target="*inputname2"]
*nameyes
[position layer="message0" page="back" visible="false"]
[hideyesno]
;注意書き表示
[暗転 ゆっくりフェード][BGM stop=3000]
[wt canskip="true"]
[EV file=notice normal]
[wt canskip="true"]
[wait time="5000" canskip="true"]
[EV hide normal][wt canskip="false"]
[EV file=staff normal]
[wt canskip="true"]
[wait time="5000" canskip="true"]
[EV hide normal][wt canskip="false"]
[EV file=declaration normal]
[wt canskip="true"]
[wait time="5000" canskip="true"]
[EV hide normal][wt canskip="false"]


*start|オープニングへ
[eval exp=kag.addBookMarkInfo("date",00)]
[eval exp=kag.addBookMarkInfo("char","")]
;メニュー有効
[rclick enabled=true]
;ログ有効
[history enabled=true output="true"]
;シーン初期化
[initscene]
[autowc enabled="false"]
[linemode]
[autoindent mode="false"]




*toopening
[jump storage="オープニング.ks" target=*start]