package jp_2dgames.game;
import jp_2dgames.lib.TmxLoader;
import jp_2dgames.lib.Array2D;
import jp_2dgames.game.token.Spike;
import jp_2dgames.game.token.Item;
import jp_2dgames.game.token.Enemy;
import flixel.util.FlxRandom;
import flixel.FlxG;
import flixel.FlxBasic;

/**
 * ゲームオブジェクトの出現管理
 **/
class LevelMgr extends FlxBasic {

  var _time:Int;
  var _funcSpeed:Void->Float;

  /**
   * コンストラクタ
   **/
  public function new(funcSpeed:Void->Float) {
    super();

    _funcSpeed = funcSpeed;
    _time = 0;

    // 初期状態は無効にしておく
    active = false;
  }

  /**
   * 開始
   **/
  public function start():Void {
    active = true;
  }

  /**
   * 更新
   **/
  override public function update():Void {
    super.update();

    // 敵の出現
    _time++;
    if(_time%120 == 0) {
      var px = Wall.randomX();
      var py = FlxG.camera.scroll.y - 32;
      var base = _funcSpeed();
      var ratio = 0.9 - 0.1 * (Math.sqrt(_time* 0.0001));
      ratio -= FlxRandom.floatRanged(0, 0.2);
      if(ratio < 0.3) {
        ratio = 0.3;
      }
      var spd = base * ratio;
      Enemy.add(px, py, spd);

    }

    // 鉄球の出現
    if(_time%350 == 1) {
      // TODO:
      var tmx = new TmxLoader();
      var id = FlxRandom.intRanged(1, 10);
      var path = Reg.getMapData(id);
      tmx.load(path);
      var layer = tmx.getLayer(0);
      layer.forEach(function(i:Int, j:Int, val:Int) {
        j = (tmx.height - j) - 1;
        var x = Wall.CHIP_LEFT + i * 16;
        var y = FlxG.camera.scroll.y - 16 - (16 * j);
        if(val == 1) {
          Spike.add(x, y);
        }
      });
    }

    // アイテムの出現
    if(_time%350 == 0) {
      var px = FlxG.width/2 + FlxRandom.intRanged(-32, 32);
      var py = FlxG.camera.scroll.y - 32;
      var spd = _funcSpeed() * 0.7;
      Item.add(px, py, spd);
    }
  }
}
