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

  /**
   * 起動時に一度だけ呼び出される初期化
   **/
  public static function init():Void {
    _playData = new PlayData();
  }

  /**
   * ゲーム開始前の初期化
   **/
  public static function start():Void {
    _level = 1;
    _mileage = 0;
  }

  /**
   * レベル開始時の初期化
   **/
  public static function initLevel():Void {
    _score = 0;
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

  public static function getPlayData():PlayData {
    return _playData;
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
}
