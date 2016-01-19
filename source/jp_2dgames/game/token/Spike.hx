package jp_2dgames.game.token;
import flixel.FlxState;

/**
 * 鉄球の種別
 **/
enum SpikeType {
  None;     // 無効

  DontMove; // 動かない
  Left;     // 左に動く
  Right;    // 右に動く
}

/**
 * 鉄球
 **/
class Spike extends Token {

  // 左右の移動速度
  static inline var MOVE_SPEED:Float = 50.0;

  static var _parent:TokenMgr<Spike> = null;
  public static function createParent(state:FlxState):Void {
    _parent = new TokenMgr<Spike>(128, Spike);
    state.add(_parent);
  }
  public static function destroyParent(state:FlxState):Void {
    state.remove(_parent);
    _parent = null;
  }
  public static function forEachAlive(func:Spike->Void):Void {
    _parent.forEachAlive(func);
  }
  public static function add(type:SpikeType, X:Float, Y:Float):Spike {
    var spike:Spike = _parent.recycle();
    spike.init(type, X, Y);

    return spike;
  }
  public static function count():Int {
    return _parent.countLiving();
  }

  // ===============================================
  // ■メンバ変数
  private var _type:SpikeType;

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
  public function init(type:SpikeType, X:Float, Y:Float):Void {
    x = X;
    y = Y;
    velocity.set();
    _type = type;

    switch(_type) {
      case SpikeType.None:
      case SpikeType.DontMove:
      case SpikeType.Left:
        velocity.x = -MOVE_SPEED;
      case SpikeType.Right:
        velocity.x = MOVE_SPEED;
    }
  }

  /**
   * 更新
   **/
  override public function update():Void {
    super.update();

    // 反射チェック
    _checkReflect();

    if(isOutside()) {
      // 画面外に出たので消滅
      kill();
    }
  }

  /**
   * 反射チェック
   **/
  private function _checkReflect():Void {
    if(x < Wall.CHIP_LEFT) {
      // 反射する
      x = Wall.CHIP_LEFT;
      velocity.x *= -1;
    }
    var right = Wall.CHIP_RIGHT - width;
    if(x > right) {
      // 反射する
      x = right;
      velocity.x *= -1;
    }
  }
}
