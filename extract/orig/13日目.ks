*start|８月13日
[initscene]

;★くぉメモ：14日のキャンプ1日目のシーンが、前日夜からスタートするため、
;★13日のキャラ別シナリオの有無にかかわらず、日付表示を行う。
[eval exp=kag.addBookMarkInfo("date",13)]
[SE 朝鳥の鳴き声 loop buf=1]
[daybegin day=13]

;[if exp="f.selopchr==1"]
;辰樹編

[主人公自室 日差し][wt]

【博行】
「今天做什么好呢？」

[msgoff]
[mselinit2]
[mseladd text="map_deficon" pos="水郷分校" storage="辰樹_s_04.ks" exp="mapInfoFinalize()" onleave="mapInfoErase()" onenter="mapInfoWrite('水郷分校','t')" target=*start]

;[elsif exp="f.selopchr==2"]
;孝之助編イベントなし
;[jump target="*nextday"]

;[elsif exp="f.selopchr==3"]
;峻編

[mseladd text="map_deficon" pos="辰樹の家" storage="峻_s_01.ks" exp="mapInfoFinalize()" onleave="mapInfoErase()" onenter="mapInfoWrite('辰樹の家','u')" target=*start]

;[elsif exp="f.selopchr==4"]
;洸哉編イベントなし
;[jump target="*nextday"]

;[endif]

[SE stop=100 buf=1][wf buf=1]
[BGM play=free0422]
[mselect2]

*nextday
[SE stop=100 buf=1][wf buf=1]

*camp01|思い立ったが吉日
[主人公自室 昼 ゆっくりフェード msgoff]
[bgmopt volume=30][BGM play="蝉の環境音"][wt]

啊~,盂兰盆节都快到了啊。[l]
能住在水乡村的日子已只剩下一小半了。

不过在这的半个月里真的经历了不少事呢。[l]
首先是欢迎会，之后的时间虽然有点散乱，不过经常都能和大家一起玩，[l]
而且也有去海边呢。

真的很开心啊，还想和大家一起去玩呢。[l]
不知道会有谁来策划……。

对了！[l]　这次由[咱]来邀请就行了啊。[l]
到了月末了大家应该都会很忙的，[wdt]
果然这种事情还是快点行动比较好呢。

而且手上也有联络本，先给谁打电话呢。[l]
既然要策划的话就要先做准备吧。[l]
怎么办，先去找地方吗。

大家都方便的日子大概有多少天呢？[l]
唔~~~还是先联络下大家看看吧。[l]
然后……
[暗転 ゆっくりフェード][wt]
[jump storage="14日目.ks" target="*start"]