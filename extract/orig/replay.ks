;
; リプレイモード
;
; 使汉化组特典生效。
[eval exp="sf.trail_hanstaff_start = 1"]

[rclick enabled=true jump=true storage="" target=*backtotitle]

[eval exp='replayInit()']
;コメント表示用レイヤー
[iscript]
var comment = new global.Layer(kag, kag.back.base);
comment.setPos(217,532);
comment.setSize(583,34);
[endscript]

*loop

; ベース画像読み込み
[rclick enabled=true jump=true storage="" target=*backtotitle]
[backlay]
[position layer=message0 frame="replaymode_base" opacity=255 left=0 top=0 width=800 height=600 marginT=0 marginL=0 marginR=0 marginB=0 visible=true transparent=false page=back]
[current layer=message0 page=back]

;遷移用ボタン
[locate x=397 y=33]
[button name="extra_cgmode" storage="cgmode.ks"]
[locate x=594 y=33]
[button name="extra_replaymode" disabled]
;[locate x=563 y=47]
;[button name="extra_musicmode" storage="musicmode.ks"]
[locate x=23 y=446]
[button name="extra_return" target=*backtotitle]

;キャラ選択
[locate x=0 y=177]
[button name="replaymode_page0" exp="tf.cgmodepage=0" target="*loop"]
[locate x=0 y=239]
[button name="replaymode_page1" exp="tf.cgmodepage=1" target="*loop"]
[locate x=0 y=302]
[button name="replaymode_page2" exp="tf.cgmodepage=2" target="*loop"]
[locate x=0 y=365]
[button name="replaymode_page3" exp="tf.cgmodepage=3" target="*loop"]
;[locate x=10 y=416]
;[button name="cgmode_page4" exp="tf.cgmodepage=4" target="*loop"]
;[locate x=10 y=496]
;[button name="cgmode_page5" exp="tf.cgmodepage=5" target="*loop"]

;リプレイ選択
;１列目
[locate x=224 y=134]
[button name="cg0" normal="cgmode_thum_normal" exp="recollect(0),cgCommentErase()" onleave="cgCommentErase()" onenter="cgCommentWrite(tf.comment[0])"]
[locate x=417 y=134]
[button name="cg1" normal="cgmode_thum_normal" exp="recollect(1),cgCommentErase()" onleave="cgCommentErase()" onenter="cgCommentWrite(tf.comment[1])"]
[locate x=611 y=134]
[button name="cg2" normal="cgmode_thum_normal" exp="recollect(2),cgCommentErase()" onleave="cgCommentErase()" onenter="cgCommentWrite(tf.comment[2])"]
;[locate x=662 y=122]
;[button name="cg3" normal="cgmode_thum_normal" exp='recollect(3)']
;２列目
[locate x=224 y=325]
[button name="cg3" normal="cgmode_thum_normal" exp="recollect(3),cgCommentErase()" onleave="cgCommentErase()" onenter="cgCommentWrite(tf.comment[3])"]
[locate x=417 y=325]
[button name="cg4" normal="cgmode_thum_normal" exp="recollect(4),cgCommentErase()" onleave="cgCommentErase()" onenter="cgCommentWrite(tf.comment[4])"]
;[locate x=611 y=325]
;[button name="cg5" normal="cgmode_thum_normal" exp="recollect(5),cgCommentErase()" onleave="cgCommentErase()" onenter="cgCommentWrite(tf.comment[5])"]
;[locate x=662 y=232]
;[button name="cg7" normal="cgmode_thum_normal" exp='recollect(7)']
;３列目
;[locate x=284 y=342]
;[button name="cg8" normal="cgmode_thum_normal" exp='recollect(8)']
;[locate x=410 y=342]
;[button name="cg9" normal="cgmode_thum_normal" exp='recollect(9)']
;[locate x=536 y=342]
;[button name="cg10" normal="cgmode_thum_normal" exp='recollect(10)']
;[locate x=662 y=342]
;[button name="cg11" normal="cgmode_thum_normal" exp='recollect(11)']
;４列目
;[locate x=284 y=452]
;[button name="cg12" normal="cgmode_thum_normal" exp='recollect(12)']
;[locate x=410 y=452]
;[button name="cg13" normal="cgmode_thum_normal" exp='recollect(13)']
;[locate x=536 y=452]
;[button name="cg14" normal="cgmode_thum_normal" exp='recollect(14)']
;[locate x=662 y=452]
;[button name="cg15" normal="cgmode_thum_normal" exp='recollect(15)']

[eval exp='setReplaymodePageButton()']
[trans method=crossfade time=500]
[wt]
[current layer=message0 page=fore]
[s]

*backtotitle
[rclick enabled=false jump=false]
[jump storage="title.ks" target=*backtotitle]