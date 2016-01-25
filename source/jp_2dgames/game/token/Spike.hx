package jp_2dgames.game.token;
import jp_2dgames.lib.MyMath;
import jp_2dgames.lib.DirUtil;
import flixel.FlxState;

/**
 * 鉄球の種別
 **/
enum SpikeType {
  None;     // 無効

  DontMove;      // 動かない
  Move(dir:Dir); // 等速移動
  Sin(dir:Dir);  // Sinカーブ
  Roll(dir:Dir); // 回転
}

/**
 * 鉄球
 **/
class Spike extends Token {

  // 左右の移動速度
  static inline var MOVE_SPEED:Float = 50.0;
  // Sinカーブの移動幅
  static inline var SIN_WIDTH:Float = 32.0;
  // 回転の半径
  static inline var ROLL_WIDTH:Float = 32.0;

  static var _parent:TokenMgr<Spike> = null;
  public static function createParent(state:FlxState):Void {
    _parent = new TokenMgr<Spike>(128, Spike);
    state.add(_parent);
  }
  public static function destroyParent():Void {
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
  private var _type:SpikeType; // 種別
  private var _tPast:Int;      // 経過フレーム数

  /**
   * コンストラクタ
   **/
  public function new() {
    super();
    animation.createPrerotated();
    loadGraphic(Reg.PATH_IMAGE_CHAR_SET, true, CharSet.WIDTH, CharSet.HEIGHT);
    {
      var anim = [for(i in 0...4) CharSet.OFS_SPIKE+i];
      animation.add("brown", anim, 8);
    }
    {
      var anim = [for(i in 0...4) CharSet.OFS_SPIKE2+i];
      animation.add("green", anim, 8);
    }
    {
      var anim = [for(i in 0...4) CharSet.OFS_SPIKE3+i];
      animation.add("red", anim, 8);
    }

    animation.play("brown");

    // 消しておく
    kill();
  }

  /**
   * 初期化
   **/
  public function init(type:SpikeType, X:Float, Y:Float):Void {
    x = X;
    y = Y;
    // 開始座標を設定
    setStartPosition(x, y);
    // 前回の座標を更新
    postUpdate();
    velocity.set();
    _type = type;
    _tPast = 0;
    angle = 0;

    // アニメーションを設定
    _changeAnim();

    switch(_type) {
      case SpikeType.None:
      case SpikeType.DontMove:
      case SpikeType.Move(dir):
        switch(dir) {
          case Dir.Left:
            velocity.x = -MOVE_SPEED;
          case Dir.Right:
            velocity.x = MOVE_SPEED;
          default:
        }
      case SpikeType.Sin(dir):
      case SpikeType.Roll:
        _updateRoll();
    }
  }

  /**
   * 更新
   **/
  override public function update():Void {
    super.update();
    _tPast++;

    // 反射チェック
    _checkReflect();

    // Sinカーブ移動の更新
    _updateSinCurve();

    // 回転座標の更新
    _updateRoll();

    if(isOutside()) {
      // 画面外に出たので消滅
      kill();
    }

    // 前回の座標を更新
    super.postUpdate();
  }

  /**
   * 回転角度を更新
   **/
  private function _updateAngle(dx:Float, dy:Float):Void {
    angle = MyMath.atan2Ex(dy, dx);
  }

  /**
   * 反射チェック
   **/
  private function _checkReflect():Void {
    switch(_type) {
      case SpikeType.Move:
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

        // 回転角度を更新
        _updateAngle(velocity.x, velocity.y);
      default:
    }
  }

  /**
   * Sinカーブの移動を更新
   **/
  private function _updateSinCurve():Void {
    switch(_type) {
      case SpikeType.Sin(dir):
        var t = _tPast;
        switch(dir) {
          case Dir.Left:
            x = xstart + SIN_WIDTH * MyMath.sinEx(t+180);
          case Dir.Right:
            x = xstart + SIN_WIDTH * MyMath.sinEx(t);
          case Dir.Up:
            y = ystart + SIN_WIDTH * MyMath.sinEx(t+180);
          case Dir.Down:
            y = ystart + SIN_WIDTH * MyMath.sinEx(t);
          default:
        }
        // 回転角度を更新
        _updateAngle(x-xprev, y-yprev);
      default:
    }
  }

  /**
   * 回転座標の更新
   **/
  private function _updateRoll():Void {
    switch(_type) {
      case SpikeType.Roll(dir):
        var t = _tPast;
        switch(dir) {
          case Dir.Left:
            x = xstart + ROLL_WIDTH * MyMath.cosEx(t);
            y = ystart + ROLL_WIDTH * MyMath.sinEx(t);
          case Dir.Right:
            x = xstart + ROLL_WIDTH * MyMath.cosEx(-t);
            y = ystart + ROLL_WIDTH * MyMath.sinEx(-t);
          default:
        }
        // 回転角度を更新
        _updateAngle(x-xprev, y-yprev);
      default:
    }
  }

  /**
   * アニメーションを変更する
   **/
  private function _changeAnim():Void {
    var name = "brown";
    switch(_type) {
      case SpikeType.DontMove:
        name = "brown";
      case SpikeType.Move, SpikeType.Sin:
        name = "green";
      case SpikeType.Roll:
        name = "red";
      default:
    }

    animation.play(name);
  }
}
