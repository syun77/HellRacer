package jp_2dgames.game.state;
import jp_2dgames.game.gui.TutorialUI;
import flixel.FlxSubState;

/**
 * チュートリアル
 **/
class TutorialSubState extends FlxSubState {

  /**
   * 生成
   **/
  public override function create():Void {
    super.create();

    var ui = new TutorialUI(_cbClose);
    this.add(ui);
  }

  private function _cbClose():Void {
    // 閉じる
    close();
  }

}
