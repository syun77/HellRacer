package jp_2dgames.game;
import jp_2dgames.game.token.Player;
import jp_2dgames.lib.TmxLoader;
import jp_2dgames.lib.Array2D;
import jp_2dgames.game.token.Spike;
import jp_2dgames.game.token.Item;
import jp_2dgames.game.token.Enemy;
import flixel.util.FlxRandom;
import flixel.FlxG;
import flixel.FlxBasic;

private enum Mode {
  Fixed;  // 固定マップ
  Random; // ランダム
}

/**
 * ゲームオブジェクトの出現管理
 **/
class LevelMgr extends FlxBasic {

  // 経過フレーム数
  var _time:Int = 0;
  // プレイヤー
  var _player:Player = null;
  // 起動モード
  var _mode:Mode;
  // マップデータ
  var _map:Array2D = null;
  // 前回の座標
  var _ybase_prev:Float = 0.0;

  /**
   * コンストラクタ
   **/
  public function new(player:Player) {
    super();

    _player = player;
    _time = 0;

    // TODO: 固定マップ
    _mode = Mode.Fixed;

    // 初期状態は無効にしておく
    active = false;

    switch(_mode) {
      case Mode.Fixed: // 固定マップ
        var tmx = new TmxLoader();
        tmx.load(Reg.getFixedMapPath());
        _map = tmx.getLayer(0);

      case Mode.Random: // ランダムマップ
    }
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
      var base = _player.getSpeed();
      var ratio = 0.9 - 0.1 * (Math.sqrt(_time* 0.0001));
      ratio -= FlxRandom.floatRanged(0, 0.2);
      if(ratio < 0.3) {
        ratio = 0.3;
      }
      var spd = base * ratio;
      Enemy.add(px, py, spd);

    }

    // 鉄球の出現
    switch(_mode) {
      case Mode.Fixed:
        // 固定マップ
        _appearFixedSpike(_player.y);

      case Mode.Random:
        // TODO:
        if(_time%350 == 1) {
          // ランダム鉄球の出現
          var id = FlxRandom.intRanged(1, 10);
          _appearRandomSpike(id);
        }
    }

    // アイテムの出現
    if(_time%350 == 0) {
      var px = FlxG.width/2 + FlxRandom.intRanged(-32, 32);
      var py = FlxG.camera.scroll.y - 32;
      var spd = _funcSpeed() * 0.7;
      Item.add(px, py, spd);
    }
  }

  /**
   * 固定鉄球の出現
   **/
  private function _appearFixedSpike(ybase:Float):Void {
    _ybase_prev = ybase;
  }

  /**
   * ランダム鉄球の出現
   **/
  private function _appearRandomSpike(id:Int):Void {
    var tmx = new TmxLoader();
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
}
