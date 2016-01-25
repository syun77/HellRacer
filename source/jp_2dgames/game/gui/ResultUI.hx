package jp_2dgames.game.gui;

import flixel.FlxG;
import flixel.util.FlxColor;
import flixel.text.FlxText;
import flixel.group.FlxSpriteGroup;

/**
 * リザルトUI起動パラメータ
 **/
class ResultUIParam {
  public var score:Int = 0;
  public var scoreNew:Bool = false;
  public var mileage:Int = 0;
  public var mileageNew:Bool = false;

  public function new(score:Int, mileage:Float) {
    this.score = score;
    this.mileage = Std.int(mileage);
  }
}

/**
 * リザルトUI
 * @note 表示するもの
 * ・最終スコア
 *  ・記録更新していたら「NEW」マーク
 * ・走行距離
 *  ・記録更新していたら「NEW」マーク
 **/
class ResultUI extends FlxSpriteGroup {

  static inline var BASE_X = 0;
  static inline var BASE_OFS_Y = -32;
  static inline var OFS_Y = 16;
  static inline var NEW_OFS_Y = 2;

  // 最終スコア
  var _txtScore:FlxText;
  var _txtScoreNew:FlxText;
  // 走行距離
  var _txtMileage:FlxText;
  var _txtMileageNew:FlxText;

  /**
   * コンストラクタ
   **/
  public function new(param:ResultUIParam) {
    {
      var posY = FlxG.height/2 + BASE_OFS_Y;
      super(BASE_X, posY);
    }

    var px:Float = 0;
    var py:Float = 0;
    var width:Float = FlxG.width;
    // スコア
    var str = 'FINAL SCORE: ${param.score}';
    _txtScore = new FlxText(px, py, width, str, 12);
    _txtScore.setBorderStyle(FlxText.BORDER_OUTLINE);
    _txtScore.alignment = "center";
    this.add(_txtScore);
    var newX = FlxG.width/2 - (str.length / 2 * 12);

    if(param.scoreNew) {
      // スコアの「NEW」
      _txtScoreNew = new FlxText(newX, py+NEW_OFS_Y, 0, "NEW");
      _txtScoreNew.setBorderStyle(FlxText.BORDER_OUTLINE, FlxColor.CRIMSON);
      this.add(_txtScoreNew);
    }
    py += OFS_Y;

    // 走行距離
    _txtMileage = new FlxText(px, py, width, '${param.mileage} mile', 12);
    _txtMileage.setBorderStyle(FlxText.BORDER_OUTLINE);
    _txtMileage.alignment = "center";
    this.add(_txtMileage);

    if(param.mileageNew) {
      // 走行距離の「NEW」
      _txtMileageNew = new FlxText(newX, py+NEW_OFS_Y, 0, "NEW");
      _txtMileageNew.setBorderStyle(FlxText.BORDER_OUTLINE, FlxColor.CRIMSON);
      this.add(_txtMileageNew);
    }

    scrollFactor.set();
  }
}
