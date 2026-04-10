;
;　デバッグメニュー
;
*start|デバッグメニュー
[rclick enabled=true jump=true storage="" target=*backtotitle]

;メッセージをログに記録しない
[history output=false]

; ベース画像読み込み
[backlay]
[hideyesno]
[position layer=message1 frame="debug" left=0 top=0 width=800 height=600 marginT=0 marginL=0 marginR=0 marginB=0 visible=true  transparent=false page=back]
[current layer=message1 page=back]

; ボタンの配置

;デバッグシナリオファイル読み込み
[nowait]　　テスト実行したいファイル名を入れてOKを押してください。[r]
　　右クリックで戻る。
[eval exp=kag.addBookMarkInfo("date",00)]
[eval exp=kag.addBookMarkInfo("char","")]
[eval exp="f.mname = '西村'" cond="f.mname === void"]
[eval exp="f.fname = '博行'" cond="f.fname === void"]
[eval exp="f.fs = '漏れ'" cond="f.fs === void"]
[eval exp="f.encountMainChar = [0,1,1,1,1,1,1,1,1,1]"]
;名字
[locate x=215 y=127]
名字[edit maxchars=3 length=150 name="f.mname" opacity=122]
;名前
[locate x=463 y=127]
名前[edit maxchars=3 length=150 name="f.fname" opacity=122]
;一人称
[locate x=375 y=213]
一人称[edit maxchars=3 length=150 name="f.fs" opacity=122]
[locate x=115 y=257]
[eval exp="tf.dbtestfilename='dbtest.ks'" exp="tf.dbtestfilename!==void"]
[edit length=350 name=sf.dbtestfilename opacity=122]確認なし[checkbox opacity="112" name="sf.dbnoconf"][r][r]
　　　[checkbox opacity="112" name="sf.debugtatu"]辰樹編[r]
　　　[checkbox opacity="112" name="sf.debugkouno"]孝之助編[r]
　　　[checkbox opacity="112" name="sf.debugshun"]峻編[r]
　　　[checkbox opacity="112" name="sf.debugkouya"]洸哉編[r]
　　　[checkbox opacity="112" name="sf.debugjuichi"]柔一編[r]
　　　[checkbox opacity="112" name="sf.debugshin"]深編[r]
　　　注）複数チェック時は上にあるほうを優先します。

[locate x=335 y=433]
[button normal=namein_ok_normal target="*loadfile" clickse=pi47]
[endnowait]
[trans method="universal" rule="左上から右下へ" vague="10" time=150]
[wt]
;メッセージをログに記録する
[history output=false]
[s]

*loadfile
[backlay]
[commit]

[if exp="sf.debugtatu"]
[eval exp="f.selopchr = 1"]
[eval exp="f.encountSubChar = [0,1,1,1,1,1,1,1,0,0]"]
[elsif exp="sf.debugkouno"]
[eval exp="f.selopchr = 2"]
[eval exp="f.encountSubChar = [0,1,1,1,1,0,0,0,0,0]"]
[elsif exp="sf.debugshun"]
[eval exp="f.selopchr = 3"]
[eval exp="f.encountSubChar = [0,1,1,0,0,0,0,0,0,0]"]
[elsif exp="sf.debugkouya"]
[eval exp="f.selopchr = 4"]
[eval exp="f.encountSubChar = [0,1,1,1,1,1,0,0,0,0]"]
[elsif exp="sf.debugjuichi"]
[eval exp="f.selopchr = 5"]
[eval exp="f.encountSubChar = [0,1,1,1,1,1,0,0,0,0]"]
[elsif exp="sf.debugshin"]
[eval exp="f.selopchr = 6"]
[eval exp="f.encountSubChar = [0,1,1,1,1,1,0,0,0,0]"]
[endif]

[if exp="sf.dbnoconf && Storages.isExistentStorage(sf.dbtestfilename)"]
[jump target="*jumpdebugfile"]
[endif]
[if exp="Storages.isExistentStorage(sf.dbtestfilename)"]
[yesno]
[style align="center"][font color="0xFF8040"][emb exp="sf.dbtestfilename"][font color="default"][r]を読み込みますか?
[endyesno notarget="*start" yestarget="*jumpdebugfile"]
[jump storage=&sf.dbtestfilename target="*start"]
[else]
[infomation]
[r]
[style align="center"][font color="0xFC1003"]ファイルの読み込みに失敗しました[r]ファイル名を確認してください[resetfont]
[endinfomation target="*start" caution="true"]
[endif]

*jumpdebugfile
[initscene]
[jump storage=&sf.dbtestfilename target="*start"]

*backtotitle
[rclick enabled=false jump=false]
[eval exp='configExit()']
[current layer=message0]
[jump storage="title.ks" target=*backtotitle]