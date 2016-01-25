package jp_2dgames.game.token;

import flixel.util.FlxColor;
import jp_2dgames.game.particle.Particle;
import jp_2dgames.game.global.Global;
import jp_2dgames.game.particle.ParticleScore;
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
  public static function forEachAlive(func:Coin->Void):Void {
    _parent.forEachAlive(func);
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

  /**
   * 初期化
   **/
  public function init(X:Float, Y:Float):Void {
    x = X;
    y = Y;
  }

  /**
   * 消滅
   **/
  public function vanish():Void {

    // スコア加算
    Global.addScore(SCORE);

    // スコア演出
    var px = xcenter;
    var py = ycenter;
    ParticleScore.start(px, py, Item.SCORE);
    // エフェクト
    Particle.start(PType.Ring, px, py, FlxColor.YELLOW);

    // 消滅
    kill();
  }

  /**
   * 更新
   **/
  public override function update():Void {
    super.update();

    if(isOutside()) {
      // 画面外に出たので消滅
      kill();
    }
  }
}

