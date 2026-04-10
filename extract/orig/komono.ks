;彫暔僾儔僌僀儞 Torainu

;梮傞暥帤fontdance儅僋儘偺屇傃弌偟愭
*text_dance
[eval exp="tf.temp1=tf.text.length,tf.temp2=0,kag.clickCount=0"]
;暥帤偑偼傒弌傞偺偱暥帤偺昤夋埵抲傪忋偘傞丅
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
