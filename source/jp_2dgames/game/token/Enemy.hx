package jp_2dgames.game.token;

import flixel.FlxState;
import flixel.FlxSprite;

/**
 * 敵
 **/
class Enemy extends Token {

  static var _parent:TokenMgr<Enemy> = null;
  public static function createParent(state:FlxState):Void {
    _parent = new TokenMgr<Enemy>(32, Enemy);
    state.add(_parent);
  }
  public static function destroyParent():Void {
    _parent = null;
  }
  public static function forEachAlive(func:Enemy->Void):Void {
    _parent.forEachAlive(func);
  }
  public static function add(X:Float, Y:Float, Speed:Float):Enemy {
    var e:Enemy = _parent.recycle();
    e.init(X, Y, Speed);

    return e;
  }
  public static function count():Int {
    return _parent.countLiving();
  }

  /**
   * コンストラクタ
   **/
  public function new() {
    super();

    loadGraphic(Reg.PATH_IMAGE_CAR);
    angle = -90;

    // 非表示にしておく
    kill();
  }

  /**
   * 初期化
   **/
  public function init(X:Float, Y:Float, Speed:Float):Void {
    x = X;
    y = Y;
    velocity.y = -Speed;
  }

  /**
   * 更新
   **/
  override public function update():Void {
    super.update();

    if(isOutside()) {
      // 画面外に出たので消滅
      kill();
    }
  }
}
