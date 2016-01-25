package jp_2dgames.game.state;
import jp_2dgames.game.gui.MyButton2;
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

    // タイトル画面に戻るボタン
    var px = FlxG.width/2;
    var py = FlxG.height/2 * 1.7;
    var btn = new MyButton2(px, py, "Back", function() {
      FlxG.switchState(new TitleState());
    });
    btn.x -= btn.width/2;
    this.add(btn);
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
  }
}
