package jp_2dgames.game.token;
import jp_2dgames.game.global.Global;
import flixel.FlxG;
import jp_2dgames.game.global.PlayData;
import jp_2dgames.lib.Snd;
import flixel.util.FlxColor;
import jp_2dgames.game.particle.Particle;
import flixel.util.FlxAngle;
import flixel.FlxSprite;

/**
 * プレイヤー
 **/
class Player extends Token {

  static inline var DECAY_ROLL = 0.1;

  private var _speed:Float = 0.0;
  public function getSpeed():Float {
    return _speed;
  }

  private var _tFrame:Float = 0.0;
  private var _active:Bool = false;

  /**
   * コンストラクタ
   **/
  public function new(X:Float, Y:Float) {
    super(X, Y);
    loadGraphic(Reg.PATH_IMAGE_CAR_RED);
    x -= width/2;

    angle = -90;
  }

  /**
   * 死亡演出
   **/
  public function vanish():Void {

    Particle.start(PType.Circle, xcenter, ycenter, FlxColor.RED);
    kill();
    Snd.playSe("destroy2");
  }

  /**
   * ゲーム開始
   **/
  public function start():Void {
    _active = true;
    _speed = Reg.SPEED_INIT;
    velocity.y = -1;
  }

  public function addFrameTimer(v:Int):Void {
    _tFrame += v;
  }

  /**
   * 旋回する
   **/
  public function roll(d:Float):Void {
    if(_active == false) {
      return;
    }

    d *= DECAY_ROLL;
    var vx = velocity.x;
    var vy = velocity.y;
    var rot = Math.atan2(vy, vx) * FlxAngle.TO_DEG;
    rot += d;
    angle = rot;
    var radian = angle * FlxAngle.TO_RAD;
    velocity.x = _speed * Math.cos(radian);
    velocity.y = _speed * Math.sin(radian);
  }

  /**
   * 更新
   **/
  override public function update():Void {
    if(_active == false) {
      return;
    }

    // 走行距離更新
    {
      // 上に進むので符号を逆にする
      var v = -1.0 * velocity.y/FlxG.updateFramerate * 0.01;
      PlayData.addTotalMileage(v);
      Global.addMileage(v);
    }

    super.update();

    _tFrame++;
    _speed = Reg.SPEED_INIT + Math.sqrt(_tFrame * 0.0001) * 100;

    if(Wall.clip(this)) {
      // 壁に衝突
      vanish();
    }
  }
}
