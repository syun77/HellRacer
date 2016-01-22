package jp_2dgames.game.global;

/**
 * プレイデータ
 **/
class PlayData {

  public var totalTimePlayed:Float = 0.0; // プレイ時間
  public var playCount:Int = 0; // プレイ回数(表示しない)
  public var totalDeath:Int = 0; // 死亡回数
  public var totalCopleted:Int = 0; // クリア回数
  public var totalMileage:Float = 0.0; // 総走行距離
  public var longestMileage:Float = 0.0; // 最長走行距離
  public var averagePerMileage:Float = 0.0; // 平均走行距離

  public function new() {
  }

  public function copy(data:Dynamic):Void {
    totalCopleted = data.totalCopleted;
    playCount = data.playCount;
    totalDeath = data.totalDeath;
    totalCopleted = data.totalCopleted;
    totalMileage = data.totalMileage;
    longestMileage = data.longestMileage;
    averagePerMileage = data.averagePerMileage;
  }
}
