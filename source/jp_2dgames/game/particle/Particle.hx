package jp_2dgames.game.particle;

import flixel.FlxG;
import flixel.FlxCamera;
import flixel.FlxState;
import flixel.util.FlxAngle;
import flash.display.BlendMode;
import flixel.util.FlxRandom;
import flixel.group.FlxTypedGroup;
import flixel.FlxSprite;

/**
 * パーティクルの種類
 **/
enum PType {
  Circle;  // 円
  Circle2; // 円2
  Ring;    // リング
  Ring2;   // リング2
  Ring3;   // リング3(逆再生)
}

/**
 * パーティクル
 **/
class Particle extends FlxSprite {

  // パーティクル管理
  public static var parent:FlxTypedGroup<Particle> = null;

  /**
   * 生成
   **/
  public static function createParent(state:FlxState):Void {
    parent = new FlxTypedGroup<Particle>(256);
    for(i in 0...parent.maxSize) {
      parent.add(new Particle());
    }
    state.add(parent);
  }

  /**
   * 消滅
   **/
  public static function destroyParent():Void {
    parent = null;
  }

  /**
   * 開始
   **/
  public static function start(type:PType, X:Float, Y:Float, color:Int):Void {

    X += -FlxG.camera.scroll.x;
    Y += -FlxG.camera.scroll.y;

    switch(type) {
      case PType.Circle:
        var dir = FlxRandom.floatRanged(0, 45);
        for(i in 0...8) {
          var p:Particle = parent.recycle();
          var spd = FlxRandom.floatRanged(100, 400);
          var t = FlxRandom.intRanged(40, 60);
          p.init(type, t, X, Y, dir, spd);
          p.color = color;
          dir += FlxRandom.floatRanged(40, 50);
        }
      case PType.Ring, PType.Ring2, PType.Ring3:
        var t = 60;
        var p:Particle = parent.recycle();
        p.init(type, t, X, Y, 0, 0);
        p.color = color;

      case PType.Circle2:
        var p:Particle = parent.recycle();
        var spd = FlxRandom.floatRanged(10, 20);
        var t = FlxRandom.intRanged(40, 60);
        p.init(type, t, X, Y, 90, spd);
        p.color = color;
    }
  }

  // 種別
  private var _type:PType;
  // タイマー
  private var _timer:Int;
  // 開始タイマー
  private var _tStart:Int;
  // 拡張パラメータ
  private var _val:Float;
  // 最初のX座標
  private var _xprev:Float;

  /**
	 * コンストラクタ
	 **/

  public function new() {
    super();
    loadGraphic(Reg.PATH_EFFECT, true);

    // アニメーション登録
    animation.add('${PType.Circle}', [0], 1);
    animation.add('${PType.Ring}', [1], 2);
    animation.add('${PType.Ring2}', [1], 2);
    animation.add('${PType.Ring3}', [1], 2);
    animation.add('${PType.Circle2}', [0], 1);

    // 中心を基準に描画
    offset.set(width / 2, height / 2);

    // 加算ブレンド
    blend = BlendMode.ADD;

    // スクロール無効
    scrollFactor.set();

    // 非表示
    kill();
  }

  /**
   * 初期化
   **/
  public function init(type:PType, timer:Int, X:Float, Y:Float, direction:Float, speed:Float):Void {
    _type = type;
    animation.play('${type}');
    _timer = timer;
    _tStart = timer;
    _val = 0;
    _xprev = X;

    // 座標と速度を設定
    x = X;
    y = Y;
    var rad = FlxAngle.asRadians(direction);
    velocity.x = Math.cos(rad) * speed;
    velocity.y = -Math.sin(rad) * speed;

    // 初期化
    alpha = 1.0;
    switch(_type) {
      case PType.Circle:
        scale.set(0.5, 0.5);
        acceleration.y = 300;
      case PType.Ring, PType.Ring2, PType.Ring3:
        scale.set(0, 0);
        acceleration.y = 0;
      case PType.Circle2:
        scale.set(0.25, 0.25);
        acceleration.y = -200;
        _val = FlxRandom.float() * 3.14*2;
    }
  }

  /**
   * 更新
   **/
  override public function update():Void {
    super.update();

    switch(_type) {
      case PType.Circle:
        _timer--;
        velocity.x *= 0.95;
        velocity.y *= 0.95;
        scale.x *= 0.97;
        scale.y *= 0.97;
      case PType.Ring:
        _timer = Std.int(_timer * 0.93);
        var sc = 1.5 * (_tStart - _timer) / _tStart;
        scale.set(sc, sc);
        alpha = _timer / _tStart;
      case PType.Ring2:
        _timer = Std.int(_timer * 0.93);
        var sc = 2 * (_tStart - _timer) / _tStart;
        scale.set(sc, sc);
        alpha = _timer / _tStart;
      case PType.Ring3:
        _timer = Std.int(_timer * 0.93);
        var sc = 3 * _timer / _tStart;
        scale.set(sc, sc);
        alpha = _timer / _tStart;
      case PType.Circle2:
        _timer--;
        _val += 0.05*2;
        if(_val > 3.14*2) {
          _val -= 3.14*2;
        }

        x = _xprev + 16 * Math.sin(_val);
        velocity.y *= 0.95;
        scale.x *= 0.97;
        scale.y *= 0.97;
    }

    if(_timer < 1) {
      // 消滅
      kill();
    }
  }
}
