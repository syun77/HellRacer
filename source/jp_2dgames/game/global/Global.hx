package jp_2dgames.game.global;

/**
 * メインゲーム中のグローバルデータ
 **/
class Global {

  // レベル
  static var _level:Int;

  // スコア
  static var _score:Int;
  // ハイスコア
  static var _hi_score:Int;

  // プレイデータ
  static var _playData:PlayData;

  /**
   * ゲーム開始前の初期化
   **/
  public static function init():Void {
    _level = 1;
    _hi_score = 0;
    _playData = new PlayData();
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

    if(_score >_hi_score) {
      // ハイスコア更新
      _hi_score = _score;
    }
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
    return _hi_score;
  }

  /**
   * ハイスコア設定
   **/
  public static function setHiScore(v:Int):Void {
    _hi_score = v;
  }

  public static function getPlayData():PlayData {
    return _playData;
  }

}
