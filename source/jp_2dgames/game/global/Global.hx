package jp_2dgames.game.global;

/**
 * メインゲーム中のグローバルデータ
 **/
class Global {

  // レベル
  static var _level:Int;

  // スコア
  static var _score:Int;

  // プレイデータ
  static var _playData:PlayData;

  // 走行距離
  static var _mileage:Float;

  // 現在のコンボ数
  static var _combo:Int;
  // 最大コンボ数
  static var _maxCombo:Int;

  // フラグ
  static var _flags:Flags;

  /**
   * 起動時に一度だけ呼び出される初期化
   **/
  public static function init():Void {
    _playData = new PlayData();
    _flags = new Flags();
  }

  /**
   * ゲーム開始前の初期化
   **/
  public static function start():Void {
    _level = 1;
    _mileage = 0;
    _combo = 0;
    _maxCombo = 0;
  }

  /**
   * レベル開始時の初期化
   **/
  public static function initLevel():Void {
    _score = 0;
    _combo = 0;
    _maxCombo = 0;
  }

  /**
   * レベルの取得
   **/
  public static function getLevel():Int {
    return _level;
  }

  /**
   * レベルを次に進める
   * @return 次のレベルが存在しない場合はfalse
   **/
  public static function nextLevel():Bool {
    _level++;
    return false;
  }

  /**
   * スコア加算
   **/
  public static function addScore(v:Int):Void {
    _score += v;
  }

  /**
   * スコア取得
   **/
  public static function getScore():Int {
    return _score;
  }

  /**
   * ハイスコア取得
   **/
  public static function getHiScore():Int {
    return PlayData.getHiscore();
  }

  /**
   * ハイスコア設定
   **/
  public static function setHiScore(v:Int):Bool {
    return PlayData.setHiscore(v);
  }

  /**
   * プレイデータを取得する
   **/
  public static function getPlayData():PlayData {
    return _playData;
  }

  /**
   * プレイデータを設定する
   **/
  public static function setPlayData(d:PlayData):Void {
    _playData.copy(d);
  }

  /**
   * 走行距離を取得する
   **/
  public static function getMileage():Float {
    return _mileage;
  }

  /**
   * 走行距離を加算する
   **/
  public static function addMileage(v:Float):Void {
    _mileage += v;
  }

  /**
   * フラグを取得する
   **/
  public static function getFlags():Flags {
    return _flags;
  }

  /**
   * フラグの値を設定する
   **/
  public static function setFlags(src:Flags):Void {
    _flags.copy(src);
  }

  /**
   * コンボ数を取得
   **/
  public static function getCombo():Int {
    return _combo;
  }

  /**
   * コンボ数を加算
   **/
  public static function addCombo():Int {
    _combo++;
    if(_combo > _maxCombo) {
      // 最大コンボを更新
      _maxCombo = _combo;
    }

    // 現在のコンボ数を返す
    return _combo;
  }

  /**
   * コンボ数をリセット
   **/
  public static function resetCombo():Void {
    _combo = 0;
  }

  /**
   * 最大コンボ数を取得する
   **/
  public static function getMaxCombo():Int {
    return _maxCombo;
  }
}
