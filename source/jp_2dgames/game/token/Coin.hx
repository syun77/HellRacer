package jp_2dgames.game.token;

import flixel.FlxState;

/**
 * コイン
 **/
class Coin extends Token {

  public static inline var SCORE:Int = 500;

  static var _parent:TokenMgr<Coin> = null;
  public static function createParent(state:FlxState):Void {
    _parent = new TokenMgr<Coin>(32, Coin);
    state.add(_parent);
  }
  public static function destroyParent():Void {
    _parent = null;
  }
  public static function add(X:Float, Y:Float):Coin {
    var coin:Coin = _parent.recycle();
    coin.init(X, Y);

    return coin;
  }
  public static function count():Int {
    return _parent.countLiving();
  }

  /**
   * コンストラクタ
   **/
  public function new() {
    super();
    loadGraphic(Reg.PATH_IMAGE_COIN, true);
    animation.add("play", [0, 1], 8);
    animation.play("play");

    // 消しておく
    kill();
  }

  public function init(X:Float, Y:Float):Void {
    x = X;
    y = Y;
  }
}

