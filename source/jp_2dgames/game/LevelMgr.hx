package jp_2dgames.game;
import jp_2dgames.game.token.Coin;
import jp_2dgames.game.token.Goal;
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

/**
 * モード
 **/
private enum Mode {
  Random; // ランダム
}

/**
 * 状態
 **/
private enum State {
  Main;     // メイン
  GoalWait; // ゴール出現
}

/**
 * ゲームオブジェクトの出現管理
 **/
class LevelMgr extends FlxBasic {

  public static inline var TILE_WIDTH:Int = 16;
  public static inline var TILE_HEIGHT:Int = 16;

  // コインのチップ番号
  static inline var CHIP_COIN:Int = 25;

  // 開始時間
  static inline var START_TIME = 0;//30 * 60;

  // 経過フレーム数
  var _time:Int = 0;
  // プレイヤー
  var _player:Player = null;
  // ゴールオブジェクト
  var _goal:Goal = null;
  // 起動モード
  var _mode:Mode;
  // マップデータ
  var _map:Array2D = null;
  // マップ出現開始座標
  var _ymap:Float = 0.0;
  // 状態
  var _state:State = State.Main;

  /**
   * コンストラクタ
   **/
  public function new(player:Player, goal:Goal) {
    super();

    _player = player;
    _goal = goal;
    _goal.kill(); // 初期状態は非表示
    _time = START_TIME;
    _ymap = 0;

    // TODO: ランダムマップ
    _mode = Mode.Random;

    // 初期状態は無効にしておく
    active = false;

    switch(_mode) {
      case Mode.Random: // ランダムマップ
    }

    _state = State.Main;
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
      case Mode.Random:
        switch(_state) {
          case State.Main:
            // ランダム鉄球の出現
            _appearRandomSpike();
          case State.GoalWait:
            // ゴールが出現したので何もしない
        }
    }
  }

  /**
   * ゴールにたどり着いたかどうかをチェックする
   **/
  public function checkGoal():Bool {
    if(_state != State.GoalWait) {
      // ゴール待ちではない
      return false;
    }

    if(_player.y < _goal.y) {
      // ゴールよりも上にいる
      return true;
    }

    if(FlxG.overlap(_player, _goal)) {
      // 衝突した
      return true;
    }

    // ゴールに接触していない
    return false;
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

  /**
   * ランダム鉄球の出現チェック
   * @return 出現できるなら true
   **/
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

  private function _chipToX(i:Int):Float {
    return Wall.CHIP_LEFT + i * 16;
  }
  private function _chipToY(j:Int):Float {
    return FlxG.camera.scroll.y - (16 * j);
  }

  /**
   * ランダム鉄球の出現
   **/
  private function _appearRandomSpike():Void {

    if(_checkRandomSpike() == false) {
      // 出現しない
      return;
    }

    // 鉄球が出現できる
    if(LimitMgr.timesup()) {
      // 時間切れしていたらゴール出現
      var py = FlxG.camera.scroll.y;
      _goal.y = py;
      _goal.revive();
      FlxG.state.add(_goal);
      _state = State.GoalWait;
      return;
    }

    // 読み込む
    _ymap = FlxG.camera.scroll.y;
    var id = _getRandomMapID();
    var tmx = new TmxLoader();
    var path = Reg.getMapData(id);
    tmx.load(path);
    var layer = tmx.getLayer(0);
    layer.forEach(function(i:Int, j:Int, val:Int) {
      j = (tmx.height - j) - 1;
      var x = _chipToX(i);
      var y = _chipToY(j);
      var type = SpikeUtil.toSpikeType(val);
      if(type != SpikeType.None) {
        // 鉄球出現
        Spike.add(type, x, y);
      }
    });

    // コインも出現させる
    var pt = layer.searchRandom(CHIP_COIN);
    if(pt != null) {
      trace("coin", path, pt.x, pt.y);
      pt.y = (tmx.height - pt.y) - 1;
      var x = _chipToX(Std.int(pt.x));
      var y = _chipToY(Std.int(pt.y));
      Coin.add(x, y);
      pt.put();
    }

    _map = layer;
  }

  /**
   * ランダムマップのIDを取得する
   **/
  private function _getRandomMapID():Int {
    var t = _time;
    var frame = FlxG.updateFramerate;
    if(t < frame * 30) {
      return FlxRandom.intRanged(1, 20);
    }
    else if(t < frame * 60) {
      return FlxRandom.intRanged(21, 30);
    }
    else if(t < frame * 90) {
      return FlxRandom.intRanged(31, 40);
    }
    else {
      return FlxRandom.intRanged(1, 40);
    }
  }
}
