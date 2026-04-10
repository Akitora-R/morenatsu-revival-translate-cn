@if exp="typeof(global.___random_se_object) == 'undefined'"
@iscript

// ランダムな間隔で効果音を鳴らすプラグイン

// ランダムSEクラス：WaveSoundBufferのラッパー（あるいは継承したほうが良かったか）
class RandomSe
{
	// データメンバ
	var m_plugin;			// ランダムSEプラグインへの参照
	var m_buffer_no;		// バッファ番号（0～m_random_se_max-1）
	var m_storage;			// 効果音ファイル名
	var m_min;				// 再生間隔の最小値（ミリ秒）
	var m_max;				// 再生間隔の最大値（ミリ秒）
	var m_volume;			// ボリューム（0～100000）
	var m_rest;				// 次回再生までの残りカウント（_onTimer()が呼ばれるたびに-1していく）
	var m_sound_buffer;		// サウンドバッファ

	// 以下は定数として扱う
	var m_const_bookmark = "___random_se_plugin_buf";
							// 栞（Dictionary）に保存する時の要素名（後ろにバッファ番号が付く）

	// 乱数を返すサブ関数（プライベートメンバ扱い）
	function _get_count()
	{
		return intrandom(m_min\m_plugin.m_const_interval, m_max\m_plugin.m_const_interval);
	}

	function RandomSe(parent, window, no)
	{
		m_plugin = parent;
		m_buffer_no = no;

		// サウンドバッファを新規に確保
		m_sound_buffer = new WaveSoundBuffer(window);

		_init();
	}

	function finalize()
	{
		invalidate m_sound_buffer;
	}

	// ランダムSEの設定を初期状態に戻す
	function _init()
	{
		// 各メンバのデフォルト値を設定
		m_storage = "";
		m_min = 0;
		m_max = int(m_plugin.m_const_interval * 5);
		m_volume = 100000;
		m_rest = _get_count();

		if (m_sound_buffer.status == "play") {
			m_sound_buffer.stop();
		}
	}

	// 準備
	// 属性：buf…バッファ番号、storage…効果音ファイル名、min/max…再生間隔の最小・最大値（ミリ秒）、volume…ボリューム（0～100%）
	// ランダムSEではbuf以外の属性を処理する（buf属性はランダムSEプラグインでは処理する）
	function _setopt(elm)
	{
		if (elm.min !== void) {		// 再生間隔の最小値を獲得
			if (elm.min < 0) {
				throw new Exception("RandomSe._setopt(): [buf="+m_buffer_no+"] min属性値は０以上にしなくてはなりません：min = "+elm.min);
			}
			m_min = +elm.min;
		}

		if (elm.max !== void) {		// 再生間隔の最大値を獲得
			if (elm.max < m_plugin.m_const_interval) {
				throw new Exception("RandomSe._setopt(): [buf="+m_buffer_no+"] max属性値は"+m_plugin.m_const_interval+"以上にしなくてはなりません：max = "+elm.max);
			}
			m_max = +elm.max;
		}

		if (elm.volume !== void) {
			if (elm.volume < 0 || 100 < elm.volume) {
				throw new Exception("RandomSe._setopt(): [buf="+m_buffer_no+"] volume属性で指定可能な値の範囲は0～100です：volume = "+elm.volume);
			}
			m_sound_buffer.volume = m_volume = int(+elm.volume * 1000);
		}

		if (elm.storage !== void && elm.storage.length > 0) {
			if (Storages.isExistentStorage(elm.storage) == false) {
				throw new Exception("RandomSe._start(): [buf="+m_buffer_no+"] storage属性で指定された効果音ファイルがありません：storage = "+m_storage);
			}
			m_storage = elm.storage;
			m_sound_buffer.open(m_storage);
		}

		m_rest = _get_count();
	}

	// タイマーイベントの発行開始
	function _start()
	{
		if (m_min >= m_max) {
			throw new Exception("RandomSe._start(): [buf="+m_buffer_no+"] min属性値はmax属性値より小さくしなくてはなりません：min = "+m_min+"、max = "+m_max);
		}
		m_sound_buffer.volume = m_volume;	// フェードアウトで０になっている可能性があるので再設定
	}

	// タイマーイベントの発行終了
	// 属性：time…フェードアウト時間（ミリ秒）
	function _stop(elm)
	{
		var time = -1;			// フェードアウト時間；０より小さければフェードアウトせずに停止
		if (elm.time !== void) {
			if (elm.time < 0) {
				throw new Exception("RandomSe._stop(): [buf="+m_buffer_no+"] time属性値は０以上にしなくてはなりません：time = "+elm.time);
			}
			time = elm.time;
		}

		if (m_sound_buffer.status == "play") {
			if (time < 0) {
				m_sound_buffer.stop();
			}
			else {
				m_sound_buffer.fade(0, time);
			}
		}
	}

	function _onTimer()
	{
		// 効果音ファイルが指定されていないか、オープンしていなければ何もしない：setopt未設定
		if (m_storage == "" || m_sound_buffer.status == "unload") {
			return;
		}

		// 再生中なら何もしない
		//if (m_sound_buffer.status == "play") {
		//	return;
		//}

		// 残りカウントが０になったら再生し、残りカウントを設定し直す
		m_rest--;
		//if (m_rest <= 0 && m_sound_buffer.status == "stop") {
		if (m_rest <= 0) {
			if (m_sound_buffer.volume != m_volume) {	// フェードアウト中に_start()が呼ばれた場合の対応
				m_sound_buffer.volume = m_volume;
			}
			m_sound_buffer.play();
			m_rest = _get_count();
		}
	}

	function _onStore(f, elm)
	{
		// 栞を保存する際に呼ばれる
		// f = 保存先の栞データ ( Dictionary クラスのオブジェクト )
		// elm = tempsave 時のオプション ( 現在は常に void )
		var key = m_const_bookmark+m_buffer_no;
		var dic = f[key] = %[];
		dic.storage = m_storage;
		dic.min = m_min;
		dic.max = m_max;
		dic.volume = m_volume\1000;
	}

	function _onRestore(f, clear, elm)
	{
		// 栞を読み出すときに呼ばれる
		// f = 読み込む栞データ ( Dictionary クラスのオブジェクト )
		// clear = メッセージレイヤをクリアするか ( tempload の時のみ false )
		// elm = tempload 時のオプション ( tempload でない場合は 常に void,
		//                                 tempload の時は Dictionary クラスのオブジェクト )
		var key = m_const_bookmark+m_buffer_no;
		var dic = f[key];
		if (dic !== void) {
			_setopt(%[storage:dic.storage, min:dic.min, max:dic.max, volume:dic.volume]);
		}
	}
}

// ランダムSEプラグインクラス
class RandomSePlugin extends KAGPlugin
{
	// データメンバ
	var m_random_ses = [];	// ランダムSEオブジェクトの配列
	var m_timer;			// タイマー

	// 以下は定数として扱う
	var m_const_interval = 50;	// タイマーイベントの発行間隔：500ミリ秒
	var m_const_bookmark = "___random_se_plugin";	// 栞（Dictionary）に保存する時の要素名
	var m_random_se_max  = 5;	// ランダムSEオブジェクトの個数（同時発音数）

	// コンストラクタ
	function RandomSePlugin(window)
	{
		super.KAGPlugin();	// スーパークラスのコンストラクタを呼ぶ

		for (var i = 0; i < m_random_se_max; i++) {
			m_random_ses[i] = new RandomSe(this, window, i);
		}

		// タイマーを生成
		m_timer = new Timer(onTimer, '');
		m_timer.interval = m_const_interval;	// タイマーイベントのインターバルを設定
		m_timer.enabled = false;				// まだタイマーイベントは発生させない
	}

	// デストラクタ
	function finalize()
	{
		exit();
		super.finalize(...);
	}

	// 準備
	// 属性：buf…バッファ番号、storage…効果音ファイル名、min/max…再生間隔の最小・最大値（ミリ秒）、volume…ボリューム（0～100%）
	// ランダムSEプラグインではbuf属性のみ処理し、それ以外の属性はランダムSEオブジェクトにスルー
	function setopt(elm)
	{
		var buf = 0;
		if (elm.buf !== void) {
			if (elm.buf < 0 || elm.buf >= m_random_se_max) {
				throw new Exception("RandomSePlugin.setopt(): buf属性値で指定可能な値は0～"+(random_se_max-1)+"です：buf = "+elm.buf);
			}
			buf = elm.buf;
		}
		m_random_ses[buf]._setopt(elm);
	}

	// タイマーイベントの発行開始
	function start()
	{
		for (var i = 0; i < m_random_ses.count; i++) {
			m_random_ses[i]._start();
		}
		m_timer.enabled = true;
	}

	// タイマーイベントの発行終了
	// 属性：time…フェードアウト時間（ミリ秒）
	function stop(elm)
	{
		m_timer.enabled = false;
		for (var i = 0; i < m_random_ses.count; i++) {
			m_random_ses[i]._stop(elm);
		}
	}

	// 各ランダムSEの設定を初期状態に戻す
	function init()
	{
		for (var i = 0; i < m_random_ses.count; i++) {
			m_random_ses[i]._init();
		}
	}

	// 終了処理
	function exit()
	{
		for (var i = 0; i < m_random_ses.count; i++) {
			invalidate m_random_ses[i];
		}
		invalidate m_timer;
	}

	// タイマーイベントで呼び出されるコールバック関数
	function onTimer()
	{
		for (var i = 0; i < m_random_ses.count; i++) {
			m_random_ses[i]._onTimer();
		}
	}

	function onStore(f, elm)
	{
		// 栞を保存する際に呼ばれる
		// f = 保存先の栞データ ( Dictionary クラスのオブジェクト )
		// elm = tempsave 時のオプション ( 現在は常に void )
		var dic = f[m_const_bookmark] = %[];
		if (m_timer.enabled == true) {
			dic.is_active = 1;
		}
		else {
			dic.is_active = 0;
		}

		for (var i = 0; i < m_random_ses.count; i++) {
			m_random_ses[i]._onStore(f, elm);
		}
	}

	function onRestore(f, clear, elm)
	{
		// 栞を読み出すときに呼ばれる
		// f = 読み込む栞データ ( Dictionary クラスのオブジェクト )
		// clear = メッセージレイヤをクリアするか ( tempload の時のみ false )
		// elm = tempload 時のオプション ( tempload でない場合は 常に void,
		//                                 tempload の時は Dictionary クラスのオブジェクト )
		var dic = f[m_const_bookmark];
		if (dic !== void) {
			if (dic.is_active != 1) {
				var dummy = %[];	// 空の辞書（辻褄合わせのダミー）
				stop(dummy);
			}
			else {
				start();
			}
		}

		for (var i = 0; i < m_random_ses.count; i++) {
			m_random_ses[i]._onRestore(f, clear, elm);
		}
	}
}

kag.addPlugin(global.___random_se_object = new RandomSePlugin(kag));
	// プラグインオブジェクトを作成し、登録する
@endscript
@endif
; プラグインの設定
@macro name="randomse_setopt"
@eval exp="___random_se_object.setopt(mp)"
@endmacro
; ランダムな時間間隔で効果音を再生
@macro name="randomse_start"
@eval exp="___random_se_object.start()"
@endmacro
; 効果音の再生を停止
@macro name="randomse_stop"
@eval exp="___random_se_object.stop(mp)"
@endmacro
; 各ランダムSEの設定を初期状態に戻す
@macro name="randomse_init"
@eval exp="___random_se_object.init()"
@endmacro
; プラグインの終了処理
@macro name="randomse_exit"
@eval exp="___random_se_object.exit()"
@endmacro
;
@return
