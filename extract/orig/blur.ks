@if exp="typeof(global.blur_object) == 'undefined'"
@iscript

/* レイヤのぼかしを徐々に行うプラグイン by 虎犬*/

class BlurPlugin extends KAGPlugin
{
	
	var window; // ウィンドウオブジェクトへの参照
	var timer; //タイマーオブジェクト
	var tempLayer; //作業レイヤー
	var targetLayerName; // 対象レイヤ名
	var targetLayer; // 対象レイヤ
	var tergetLayerBack; //対象レイヤーのback
	var l; //目標ぼかし量
	var tl; //ぼかし量
	var fadeout; //ぼかしながら徐々に消えるかfalseだと現れる
	var dtl; //ぼかしの変化量
	var dt; //更新時間間隔
	var onblur=false; //ぼかし処理中か
	
	//コンストラクタ
	function BlurPlugin(window)
	{
		super.KAGPlugin();
		this.window = window;
	}
	
	//デストラクタ
	function finalize()
	{
		// このクラスの管理するすべてのオブジェクトを明示的に破棄
		invalidate tempLayer if tempLayer !== void;
		super.finalize(...);
	}
	
	//ぼかしの開始
	function startBlur(layer='0',l,dtl=1,dt=50,fadeout=true)
	{
		this.l = (int)l;
		this.dtl = (int)dtl;
		this.dt = (int)dt;
		this.fadeout = fadeout;
		this.onblur = true;
		
		if( fadeout==true ) this.tl = 0; else this.tl = l;
		
		//作業レイヤの確保
		if(tempLayer === void)
		{
			tempLayer = new Layer(window, window.fore.base);
			tempLayer.face=dfMain;
		}

		//ターゲットレイヤの設定
		this.targetLayerName = layer;
		
		if( layer == 'base')
		{
			this.targetLayer = window.fore.base;
			this.targetLayerBack = window.back.base;
		}
		else
		{
			this.targetLayer = window.fore.layers[+layer];
			this.targetLayerBack = window.back.layers[+layer];
		}
		
		timer = new Timer(onTimer, '');
		timer.interval = dt;
		timer.enabled = true;
	}
	
	//タイマーイベントごとに呼ばれる実際にぼかしをするメソッド
	function onTimer()
	{
		if( fadeout == true )
		{
			if( tl < l && kag.skipMode<1 && !kag.noeffect){
				tempLayer.assignImages(targetLayerBack);
				tempLayer.doBoxBlur(tl,tl);
				tl += dtl;
				targetLayer.assignImages(tempLayer);
			}else{
				this.stop();
			}
		}else{
			if( tl > 0 && kag.skipMode<1 && !kag.noeffect){
				tempLayer.assignImages(targetLayerBack);
				tempLayer.doBoxBlur(tl,tl);
				tl -= dtl;
				targetLayer.assignImages(tempLayer);
			}else{
				this.stop();
			}
		}
	}
	
	//ぼかしの停止
	function stop()
	{
		invalidate timer;
		timer = void;
		
		if( fadeout == true )
		{
			tempLayer.assignImages(targetLayerBack);
			tempLayer.doBoxBlur(l,l);
			targetLayer.assignImages(tempLayer);
		}else{
			targetLayer.assignImages(targetLayerBack);
		}
		kag.trigger("blur_finished");
		this.onblur=false;
	}
}

// KAGプラグインオブジェクトを作成し、登録
var blur_object = new Array(); // オブジェクト変数を配列にする
var blur_max = 3; // 最大同時実行数（3つ）
var blur_ptr;
for( blur_ptr=0 ; blur_ptr<blur_max ; blur_ptr++ )
{
	kag.addPlugin(global.blur_object[blur_ptr] = new BlurPlugin(kag));
	// プラグインオブジェクトを作成し、登録する
}
@endscript

@endif

; マクロの登録

; ぼかし開始
@macro name="blur_start"
@eval exp="blur_object[+mp.object].startBlur(mp.layer,mp.l,mp.dtl,mp.dt,mp.fadeout)" cond="mp.object!=void"
@eval exp="blur_object[0].startBlur(mp.layer,mp.l,mp.dtl,mp.dt,mp.fadeout)" cond="mp.object==void"
@endmacro

@macro name="wblur"
@eval exp="mp.object=0" cond="mp.object==void"
@if exp="blur_object[+mp.object].onblur"
@waittrig * name="blur_finished" onskip="blur_object[+mp.object].stop()"
@endif

@endmacro

@return