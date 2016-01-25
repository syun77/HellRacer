package jp_2dgames.game;

import jp_2dgames.game.global.PlayData;
import jp_2dgames.game.global.Global;
import jp_2dgames.game.token.Spike;
import jp_2dgames.lib.Snd;
import jp_2dgames.game.token.Token;
import jp_2dgames.game.token.Enemy;
import jp_2dgames.game.token.Item;
import jp_2dgames.game.token.Player;

/**
 * メインゲームのシーケンス管理
 **/
class SeqMgr {

  // procの返却値
  public static inline var RET_NONE:Int     = 0; // 特に何もなし
  public static inline var RET_GAMEOVER:Int = 1; // ゲームオーバー
  public static inline var RET_GOAL:Int     = 2; // ゴールにたどりついた

  // スコア加算と見なされる距離
  static inline var SCORE_DISTANCE:Int = 10;
  // 距離あたりのスコア
  static inline var DISTANCE_PER_SCORE:Int = 10;


  var _player:Player;
  var _levelMgr:LevelMgr;
  var _yprev:Float = 0.0;
  var _yincrease:Float = 0.0;

  /**
   * コンストラクタ
   **/
  public function new(player:Player, levelMgr:LevelMgr) {
    _player = player;
    _levelMgr = levelMgr;
    _yprev = _player.y;
  }

  /**
   * 更新
   **/
  public function proc():Int {

    // ゲームプレイ時間更新
    PlayData.update();

    // 移動距離計算 (上に進むのでマイナスする)
    _yincrease += -(_player.y - _yprev);
    if(_yincrease > SCORE_DISTANCE) {
      // 移動距離に応じてスコア増加
      var d = Math.floor(_yincrease / SCORE_DISTANCE);
      Global.addScore(d * DISTANCE_PER_SCORE);
      _yincrease -= d * SCORE_DISTANCE;
    }
    _yprev = _player.y;

    // 衝突判定
    _checkCollide();

    if(_player.alive == false) {
      // ゲームオーバー
      return RET_GAMEOVER;
    }

    /*
    if(LimitMgr.timesup()) {
      // 時間切れ
      return RET_TIMEISUP;
    }
    */
    if(_levelMgr.checkGoal()) {
      // ゴールにたどり着いた
      return RET_GOAL;
    }

    return RET_NONE;
  }

  /**
   * プレイヤー死亡
   **/
  private function _dead():Void {

    if(_player.exists == false) {
      // すでに死んでいたら何もしない
      return;
    }

    _player.vanish();
  }

  /**
   * 衝突判定
   **/
  private function _checkCollide():Void {

    // プレイヤー vs アイテム
    Item.forEachAlive(function(item:Item) {
      if(Token.checkHitCircle(_player, item)) {
        // アイテム獲得
        item.vanish();
        // 速度上昇
        _player.addFrameTimer(60 * 60);

        Snd.playSe("powerup");
      }
    });

    // プレイヤー vs 敵
    Enemy.forEachAlive(function(e:Enemy) {
      if(Token.checkHitCircle(_player, e)) {
        // プレイヤー死亡
        _dead();
      }
    });

    // プレイヤー vs 鉄球
    Spike.forEachAlive(function(spike:Spike) {
      if(Token.checkHitCircle(_player, spike)) {
        // プレイヤー死亡
        _dead();
      }
    });
  }
}
