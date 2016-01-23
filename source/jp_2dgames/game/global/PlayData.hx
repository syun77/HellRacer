package jp_2dgames.game.global;

/**
 * プレイデータ
 **/
import flixel.FlxG;
class PlayData {

  public var hiscore:Int           = 0; // ハイスコア
  public var totalTimePlayed:Float = 0.0; // プレイ時間
  public var totalDeath:Int        = 0; // 死亡回数
  public var totalCompleted:Int    = 0; // クリア回数
  public var totalMileage:Float    = 0.0; // 総走行距離
  public var longestMileage:Float  = 0.0; // 最長走行距離

  public function new() {
  }

  public function copy(data:Dynamic):Void {
    hiscore         = data.hiscore;
    totalTimePlayed = data.totalTimePlayed;
    totalDeath      = data.totalDeath;
    totalCompleted  = data.totalCompleted;
    totalMileage    = data.totalMileage;
    longestMileage  = data.longestMileage;
  }

  // ===========================================
  // アクセス関数
  // ===========================================
  /**
   * デバッグ出力
   **/
  public static function dump():Void {
    var d = get();
    trace('Hiscore = ${d.hiscore}');
    trace('Total Time Played = ${d.totalTimePlayed}');
    trace('Total Death = ${d.totalDeath}');
    trace('Total Completed = ${d.totalCompleted}');
    trace('Total Mileage = ${d.totalMileage}');
    trace('Longest Mileage = ${d.longestMileage}');
  }

  /**
   * thisポインタ取得
   **/
  public static function get():PlayData {
    // Globalで作られるのでそこから取得
    return Global.getPlayData();
  }

  /**
   * 更新
   **/
  public static function update():Void {
    var d = get();
    // プレイ時間経過
    d.totalTimePlayed += FlxG.elapsed;
  }

  /**
   * ハイスコア取得
   **/
  public static function getHiscore():Int {
    return get().hiscore;
  }

  /**
   * ハイスコア設定
   **/
  public static function setHiscore(v:Int):Bool {
    var d = get();
    if(v > d.hiscore) {
      // ハイスコア更新
      d.hiscore = v;
      return true;
    }

    // 更新しない
    return false;
  }

  /**
   * プレイ時間の取得
   **/
  public static function getTotalTimePlayed():Int {
    return Std.int(get().totalTimePlayed);
  }

  /**
   * プレイ回数を取得する
   **/
  public static function getPlayCount():Int {
    var d = get();
    return d.totalDeath + d.totalCompleted;
  }

  /**
   * 死亡回数を取得する
   **/
  public static function getTotalDeath():Int {
    return get().totalDeath;
  }

  /**
   * 死亡回数を加算する
   **/
  public static function addTotalDeath():Void {
    get().totalDeath++;
  }

  /**
   * クリア回数を取得する
   **/
  public static function getTotalCompleted():Int {
    return get().totalCompleted;
  }

  /**
   * クリア回数を加算する
   **/
  public static function addTotalCompleted():Void {
    get().totalCompleted++;
  }

  /**
   * 総走行距離を取得する
   **/
  public static function getTotalMileage():Int {
    return Std.int(get().totalMileage);
  }

  /**
   * 総走行距離を加算する
   **/
  public static function addTotalMileage(v:Float):Void {
    get().totalMileage += v;
  }

  /**
   * 最長走行距離を取得する
   **/
  public static function getLongestMileage():Int {
    return Std.int(get().longestMileage);
  }

  /**
   * 最長走行距離を設定する
   **/
  public static function setLongestMileage(v:Float):Bool {
    var d = get();
    if(v > d.longestMileage) {
      // 記録更新
      d.longestMileage = v;
      return true;
    }
    return false;
  }

  /**
   * 平均走行距離を取得する
   **/
  public static function getAveragePerMileage():Float {
    var d = get();
    var count = getPlayCount();
    return d.totalMileage / count;
  }
}
