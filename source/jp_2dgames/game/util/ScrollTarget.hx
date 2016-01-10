package jp_2dgames.game.util;
import jp_2dgames.game.token.Player;
import flixel.FlxSprite;

/**
 * スクロール注視点用オブジェクト
 **/
class ScrollTarget extends FlxSprite {

  // プレイヤーからオフセットする座標
  static inline var OFFSET_Y:Int = -48;

  // ターゲット
  var _target:Player;

  /**
   * コンストラクタ
   **/
  public function new(target:Player) {
    super(target.x, target.y);

    _target = target;
    visible = false;
  }

  /**
   * 注視点座標(X)
   **/
  private function _getTargetX():Float {
    return _target.x;
  }

  /**
   * 注視点座標(Y)
   **/
  private function _getTargetY():Float {
    return _target.y + OFFSET_Y;
  }

  /**
   * 更新
   **/
  public override function update():Void {
    super.update();

    x = _getTargetX();
    y = _getTargetY();
  }
}
