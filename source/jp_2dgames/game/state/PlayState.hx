package jp_2dgames.game.state;

import jp_2dgames.game.global.Flags;
import jp_2dgames.game.gui.ResultUI;
import jp_2dgames.game.gui.MyButton2;
import jp_2dgames.game.token.Coin;
import jp_2dgames.game.token.Goal;
import jp_2dgames.game.global.PlayData;
import jp_2dgames.game.global.Global;
import jp_2dgames.game.util.Save;
import jp_2dgames.game.util.ScrollTarget;
import jp_2dgames.game.token.Spike;
import jp_2dgames.game.gui.CaptionUI;
import jp_2dgames.game.gui.GameUI;
import jp_2dgames.game.gui.HandleUI;
import jp_2dgames.game.token.Item;
import jp_2dgames.game.token.Enemy;
import jp_2dgames.game.particle.ParticleScore;
import jp_2dgames.lib.Snd;
import jp_2dgames.lib.MyMath;
import jp_2dgames.game.particle.Particle;
import flixel.util.FlxTimer;
import flixel.util.FlxPoint;
import flixel.FlxCamera;
import jp_2dgames.game.token.Player;
import flixel.util.FlxColor;
import flixel.FlxSprite;
import flixel.FlxG;
import flixel.FlxState;
import flixel.FlxObject;
import flixel.tweens.FlxTween;
import flixel.tweens.FlxEase;

/**
 * 状態
 **/
private enum State {
  Init;     // 初期化
  Start;    // 開始
  StartWait;// 開始待ち
  Main;     // メイン
  Gameover; // ゲームオーバー
  Gameclear;// ゲームクリア
}

/**
 * メインゲーム
 **/
class PlayState extends FlxState {

  var _player:Player;
  var _captionUI:CaptionUI;
  var _levelMgr:LevelMgr;
  var _seqMgr:SeqMgr;

  var _state:State = State.Init;

  /**
   * 生成
   **/
  override public function create():Void {
    super.create();

    // ゲームデータ初期化
    Global.initLevel();

    // 制限時間
    LimitMgr.create(this);
    LimitMgr.pause();

    // 背景
    this.add(new Bg());

    // ゴール
    var goal = new Goal();
    this.add(goal);

    // プレイヤー
    _player = new Player(FlxG.width/2, FlxG.height/4);
    this.add(_player);

    // レベル
    _levelMgr = new LevelMgr(_player, goal);
    this.add(_levelMgr);

    // ゲームシーケンス管理
    _seqMgr = new SeqMgr(_player, _levelMgr);

    // アイテム
    Item.createParent(this);

    // 敵
    Enemy.createParent(this);

    // コイン
    Coin.createParent(this);

    // 鉄球
    Spike.createParent(this);

    // スコア演出
    ParticleScore.createParent(this);

    // パーティクル
    Particle.createParent(this);

    // ハンドルUIの上座標(Y)
    var yhandle:Float = FlxG.height-HandleUI.HEIGHT;

    // ハンドルUI背景
    var bgHandle = new FlxSprite(0, yhandle);
    bgHandle.makeGraphic(FlxG.width, Std.int(HandleUI.HEIGHT), FlxColor.BLACK);
    bgHandle.scrollFactor.set(0, 0);
    this.add(bgHandle);

    // ハンドルUI
    var handle = new HandleUI(0, yhandle, _player);
    this.add(handle);

    // ゲームUI
    var gameUI = new GameUI(_player.getSpeed);
    this.add(gameUI);

    // キャプションUI
    _captionUI = new CaptionUI();
    this.add(_captionUI);

    // カメラが追いかける設定
    var scrollTarget = new ScrollTarget(_player);
    this.add(scrollTarget);
    FlxG.camera.follow(scrollTarget, FlxCamera.STYLE_TOPDOWN_TIGHT);

    // 鉄球を出現させておく
    _levelMgr.update();

    _change(State.Init);

    // チュートリアル表示チェック
    if(Flags.check(Flags.TUTORIAL) == false) {
      // チュートリアル表示
      openSubState(new TutorialSubState());
      // 閲覧済みフラグを立てておく
      Flags.on(Flags.TUTORIAL);
    }
  }

  /**
   * カウントダウン
   **/
  private function _start(cnt:Int):Void {

    if(cnt <= 0) {
      // ゲーム開始
      LimitMgr.resume();
      _levelMgr.start();
      _captionUI.hide();
      _player.start();
      _change(State.Main);
      Snd.playMusic("001", false);
      return;
    }

    // カウントダウン
    Snd.playSe("countdown");
    _captionUI.show('${cnt}');
    new FlxTimer(1, function(timer:FlxTimer) {
      _start(cnt-1);
    });

  }

  /**
   * 破棄
   **/
  override public function destroy():Void {
    _player = null;
    Particle.destroyParent();
    ParticleScore.destroyParent();
    Enemy.destroyParent();
    Spike.destroyParent();
    Item.destroyParent();
    Coin.destroyParent();
    LimitMgr.terminate(this);

    super.destroy();
  }

  /**
   * 状態の変更
   **/
  private function _change(s:State):Void {
    _state = s;

    switch(s) {
      case State.Init:
      case State.Start:
      case State.StartWait:
      case State.Main:
      case State.Gameover, State.Gameclear:
        // 制限時間を停止する
        LimitMgr.pause();
    }
  }

  /**
   * 更新
   **/
  override public function update():Void {
    super.update();

    switch(_state) {
      case State.Init:
        if(subState == null) {
          _change(State.Start);
        }

      case State.Start:
        _captionUI.show("READY");
        Snd.playSe("levelup");
        new FlxTimer(2, function(timer:FlxTimer) {
          //      _start(3);
          _start(0);
        });
        _change(State.StartWait);

      case State.StartWait:

      case State.Main:
        _updateMain();
      case State.Gameover:
      case State.Gameclear:
        // プレイヤーを動かす
        {
          // 前に進むようにする
          _player.angle = -90;
          _player.velocity.x *= 0.1;
        }
        _player.update();
    }

    _updateDebug();
  }

  /**
   * リザルト表示チェック
   **/
  private function _checkResult():Void {

    // リザルト表示パラメータ
    var param = new ResultUIParam(Global.getScore(), Global.getMileage());

    // ハイスコアを設定
    if(PlayData.setHiscore(Global.getScore())) {
      // 記録を更新した
      param.scoreNew = true;
    }

    // 最長走行距離更新
    if(PlayData.setLongestMileage(Global.getMileage())) {
      // 記録更新
      param.mileageNew = true;
    }

    // コンボ更新
    if(PlayData.setMaxCombo(Global.getMaxCombo())) {
      // TODO: 記録更新
    }

    // リザルト表示
    var result = new ResultUI(param);
    this.add(result);

    // セーブデータに保存する
    Save.save(false, false);
  }

  /**
   * 更新・メイン
   **/
  private function _updateMain():Void {

    switch(_seqMgr.proc()) {
      case SeqMgr.RET_NONE:
        // 何もしない

      case SeqMgr.RET_GAMEOVER:
        // ゲームオーバー
        _change(State.Gameover);
        Snd.stopMusic();

        // ゲームオーバー回数を増やす
        PlayData.addTotalDeath();

        // リザルトチェック
        _checkResult();

        // 画面を揺らす
        FlxG.camera.flash();
        FlxG.camera.shake(0.02, 0.5, function() {
          _captionUI.show("GAME OVER");
          _showButton();
        });

      case SeqMgr.RET_GOAL:
        // ゴールにたどりついた
        Snd.playSe("goal");
        _change(State.Gameclear);

        // クリア回数を増やす
        PlayData.addTotalFinished();

        // リザルトチェック
        _checkResult();

        _player.active = false;
        _captionUI.show("FINISH!");
        _showButton();

        var obj = new FlxObject(_player.x, _player.y-48);
        obj.velocity.set(0, _player.velocity.y);
        FlxG.camera.follow(obj, FlxCamera.STYLE_TOPDOWN_TIGHT);
        FlxTween.tween(obj.velocity, {y:_player.velocity.y*0.9}, 1, {ease:FlxEase.expoOut});
        this.add(obj);
    }
  }


  // タイトルへ戻るボタンを表示
  private function _showButton(?cbFunc:Void->Void):Void {
    if(cbFunc == null) {
      // 指定がなければタイトルに戻る
      cbFunc = function() {
        FlxG.switchState(new TitleState());
      };
    }
    var px = FlxG.width/2;
    var py = FlxG.height/2 + 32;
    var btn = new MyButton2(px, py, "Back to TITLE", cbFunc);
    btn.x -= btn.width/2;
    btn.y -= btn.height/2;
    this.add(btn);
  }

  /**
   * デバッグ機能の更新
   **/
  private function _updateDebug():Void {
#if neko
    if(FlxG.keys.justPressed.ESCAPE) {
      throw "Terminate.";
    }
    if(FlxG.keys.justPressed.D) {
      // 自爆
      _player.vanish();
    }
    if(FlxG.keys.justPressed.R) {
      FlxG.resetState();
    }
    if(FlxG.keys.justPressed.S) {
      // 保存
      Save.save(true, true);
    }
    if(FlxG.keys.justPressed.A) {
      // ロード
      Save.load(true, true);
    }
    if(FlxG.keys.justPressed.P) {
      // プレイデータデバッグ出力
      PlayData.dump();
    }
#end
  }
}