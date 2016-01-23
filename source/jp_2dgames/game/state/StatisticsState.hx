package jp_2dgames.game.state;
import flixel.FlxG;
import flixel.FlxState;

/**
 * プレイデータ閲覧画面
 **/
class StatisticsState extends FlxState {
  /**
   * 生成
   **/
  override public function create():Void {
    super.create();
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

    if(FlxG.keys.justPressed.SPACE) {
      // TODO: タイトル画面に戻る
      FlxG.switchState(new TitleState());
    }
  }
}
