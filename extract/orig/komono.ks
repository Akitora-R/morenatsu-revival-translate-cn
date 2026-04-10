;小物プラグイン Torainu

;踊る文字fontdanceマクロの呼び出し先
*text_dance
[eval exp="tf.temp1=tf.text.length,tf.temp2=0,kag.clickCount=0"]
;文字がはみ出るので文字の描画位置を上げる。
[eval exp="kag.current.lineLayerBase-=(int)(kag.current.fontSize*0.3)"]
*text_dance_roop
[wait time=&intrandom(0,180) cond="tf.yopparai && kag.skipMode==0 && kag.clickCount==0"]
[eval exp="kag.current.lineLayer.font.angle=intrandom(-360,360)"]
[eval exp="Debug.message(kag.current.lineLayer.font.angle)"]
[eval exp="kag.skipMode=1" cond="kag.clickCount && kag.skipMode==0"]
[eval exp="tf.temp3=tf.text.substring(tf.temp2,1),tf.temp2++"]
[emb exp="tf.temp3"]
[jump target=*text_dance_roop cond="tf.temp1 != tf.temp2"]
[return]
