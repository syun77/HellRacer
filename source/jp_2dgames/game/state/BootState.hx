package jp_2dgames.game.state;

import jp_2dgames.game.global.Global;
import jp_2dgames.game.state.PlayInitState;
import flixel.FlxG;
import flixel.FlxState;

/**
 * タイトル画面
 **/
class BootState extends FlxState {

  /**
   * 生成
   **/
  override public function create():Void {
    super.create();

    // グローバル初期化
    Global.init();
  }

  /**
   * 破棄
   **/
  override public function destroy():Void {
    super.destroy();
  }

  /**
   * 更新
   **/
  override public function update():Void {
    super.update();

    FlxG.switchState(new TitleState());
//    FlxG.switchState(new PlayInitState());
  }
}
