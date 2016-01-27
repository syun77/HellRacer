package jp_2dgames.game.state;
import flixel.FlxG;
import jp_2dgames.game.global.Global;
import jp_2dgames.game.util.Save;
import jp_2dgames.game.gui.DialogUI;
import flixel.FlxSubState;

/**
 * ダイアログ表示
 **/
class DialogSubState extends FlxSubState {

  public override function create():Void {
    super.create();

    DialogUI.open(this, DialogUI.YESNO,
      "Are you sure you want to delete this record?",
      null,
      function(sel:Int) {
        // 閉じる
        close();

        if(sel == DialogUI.BTN_YES) {
          // セーブデータ削除
          Save.erase();
          Global.init();

          FlxG.switchState(new StatisticsState());
        }
        else {
          // 何もしない
        }
      }
    );
  }
}
