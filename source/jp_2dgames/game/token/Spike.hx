package jp_2dgames.game.token;
import flixel.FlxState;

/**
 * 鉄球
 **/
class Spike extends Token {

  static var _parent:TokenMgr<Spike> = null;
  public static function createParent(state:FlxState):Void {
    _parent = new TokenMgr<Spike>(32, Spike);
    state.add(_parent);
  }
  public static function destroyParent(state:FlxState):Void {
    state.remove(_parent);
    _parent = null;
  }
  public static function forEachAlive(func:Spike->Void):Void {
    _parent.forEachAlive(func);
  }
  public static function add(X:Float, Y:Float):Spike {
    var spike:Spike = _parent.recycle();
    spike.init(X, Y);

    return spike;
  }
  public static function count():Int {
    return _parent.countLiving();
  }

  /**
   * コンストラクタ
   **/
  public function new() {
    super();
    loadGraphic(Reg.PATH_IMAGE_CHAR_SET, true, CharSet.WIDTH, CharSet.HEIGHT);
    var anim = [for(i in 0...4) CharSet.OFS_SPIKE+i];
    animation.add("play", anim, 8);
    animation.play("play");

    // 消しておく
    kill();
  }

  /**
   * 初期化
   **/
  public function init(X:Float, Y:Float):Void {
    x = X;
    y = Y;
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
