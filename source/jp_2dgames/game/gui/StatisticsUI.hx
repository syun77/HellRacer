package jp_2dgames.game.gui;
import flixel.FlxG;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import jp_2dgames.game.global.PlayData;
import flixel.text.FlxText;
import flixel.group.FlxSpriteGroup;

/**
 * プレイデータUI
 **/
class StatisticsUI extends FlxSpriteGroup {

  // 座標
  static inline var BASE_X = 16;
  static inline var BASE_Y = 16;

  static inline var TEXT_X = 0;
  static inline var TEXT_Y = 16;

  static inline var TEXT_DY = 32;
  static inline var TEXT_SIZE = 16;

  var _txtList:List<FlxText>;

  /**
   * コンストラクタ
   **/
  public function new() {
    super(BASE_X, BASE_Y);

    _txtList = new List<FlxText>();

    var px = TEXT_X;
    var py = TEXT_Y;
    _addText(px, py, 'Hi-Score: ${PlayData.getHiscore()}');
    py += TEXT_DY;
    _addText(px, py, 'Time Played: ${PlayData.getTotalTimePlayedStr()}');
    py += TEXT_DY;
    _addText(px, py, 'Death: ${PlayData.getTotalDeath()}');
    py += TEXT_DY;
    _addText(px, py, 'Finished: ${PlayData.getTotalFinished()}');
    py += TEXT_DY;
    _addText(px, py, 'Total: ${PlayData.getTotalMileage()}mi');
    py += TEXT_DY;
    _addText(px, py, 'Longest: ${PlayData.getLongestMileage()}mi');
    py += TEXT_DY;
    _addText(px, py, 'Average: ${PlayData.getAveragePerMileage()}mi');
    py += TEXT_DY;

    var i:Int = 0;
    for(txt in _txtList) {
      var px2 = txt.x;
      txt.x = FlxG.width;
      var delay = i * 0.1;
      FlxTween.tween(txt, {x:px2}, 1, {ease:FlxEase.expoOut, startDelay:delay});
      i++;
    }
  }

  /**
   * テキストを追加する
   **/
  private function _addText(px:Float, py:Float, text:String):FlxText {
    var txt = new FlxText(px, py, 0, text, TEXT_SIZE);
    _txtList.add(txt);
    this.add(txt);
    return txt;
  }
}
