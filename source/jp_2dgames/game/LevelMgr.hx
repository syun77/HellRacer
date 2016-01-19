package jp_2dgames.game;
import jp_2dgames.game.token.Spike.SpikeType;
import jp_2dgames.game.token.SpikeUtil;
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

  public static inline var TILE_WIDTH:Int = 16;
  public static inline var TILE_HEIGHT:Int = 16;

  // 経過フレーム数
  var _time:Int = 0;
  // プレイヤー
  var _player:Player = null;
  // 起動モード
  var _mode:Mode;
  // マップデータ
  var _map:Array2D = null;
  // マップ出現開始座標
  var _ymap:Float = 0.0;

  /**
   * コンストラクタ
   **/
  public function new(player:Player) {
    super();

    _player = player;
    _time = 0;
    _ymap = 0;

    // TODO: ランダムマップ
    _mode = Mode.Random;

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
   * ゴールしたかどうか
   **/
  public function isGoal():Bool {
    if(_mode != Mode.Fixed) {
      // ゴールがあるのは固定マップのみ
      return false;
    }

    if(_player.y < _map.height * -TILE_HEIGHT) {
      // ゴールした
      return true;
    }

    return false;
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

    _time++;
    // 鉄球の出現
    switch(_mode) {
      case Mode.Fixed:
        // 固定マップ
        _appearFixedSpike();

      case Mode.Random:
        // ランダム鉄球の出現
        _appearRandomSpike();
    }
  }

  /**
   * 固定鉄球の出現
   **/
  private function _appearFixedSpike():Void {
    var py:Int = Math.floor(FlxG.camera.scroll.y / TILE_HEIGHT);
    py += _map.height;
    var h:Int  = Math.floor(FlxG.height / TILE_HEIGHT);
    for(j in py...(py+h)) {
      for(i in 0..._map.width) {
        var v = _map.get(i, j);
        var type = SpikeUtil.toSpikeType(v);
        if(type != SpikeType.None) {
          var x = i * TILE_WIDTH + Wall.CHIP_LEFT;
          var y = (_map.height-j) * -TILE_HEIGHT;
          Spike.add(type, x, y);
          _map.set(i, j, 0);
        }
        // 敵の出現
//        Enemy.add(px, py, spd);
        // アイテムの出現
//        Item.add(px, py, spd);
      }
    }
  }

  private function _checkRandomSpike():Bool {
    if(_map == null) {
      // 何も出現していない
      return true;
    }
    var py = _ymap + (_map.height * -TILE_HEIGHT);
    // 2つぶん空ける
    py -= TILE_HEIGHT*2;
    var scrollY = FlxG.camera.scroll.y;
    if(scrollY < py) {
      return true;
    }

    return false;
  }

  /**
   * ランダム鉄球の出現
   **/
  private function _appearRandomSpike():Void {

    if(_checkRandomSpike() == false) {
      return;
    }

    // 読み込む
    _ymap = FlxG.camera.scroll.y;
//    var id = FlxRandom.intRanged(1, 10);
    var id = 22; // TODO:
    var tmx = new TmxLoader();
    var path = Reg.getMapData(id);
    tmx.load(path);
    var layer = tmx.getLayer(0);
    layer.forEach(function(i:Int, j:Int, val:Int) {
      j = (tmx.height - j) - 1;
      var x = Wall.CHIP_LEFT + i * 16;
      var y = FlxG.camera.scroll.y - (16 * j);
      var type = SpikeUtil.toSpikeType(val);
      if(type != SpikeType.None) {
        Spike.add(type, x, y);
      }
    });
    _map = layer;
  }
}
