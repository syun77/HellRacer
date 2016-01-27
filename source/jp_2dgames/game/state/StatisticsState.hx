package jp_2dgames.game.state;
import jp_2dgames.game.global.Global;
import jp_2dgames.game.util.Save;
import flixel.ui.FlxButton;
import flixel.util.FlxColor;
import flixel.FlxSprite;
import jp_2dgames.game.gui.StatisticsUI;
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

    // 背景
    this.add(new FlxSprite(0, FlxG.height/2-120, Reg.PATH_IMAGE_TITLE));
    var bg = new FlxSprite(0, 0).makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
    bg.alpha = 0.7;
    this.add(bg);

    // 項目表示
    this.add(new StatisticsUI());

    // タイトル画面に戻るボタン
    {
      var px = FlxG.width/2;
      var py = FlxG.height/2 * 1.6;
      var btn = new MyButton2(px, py, "Back", function() {
        FlxG.switchState(new TitleState());
      });
      btn.x -= btn.width/2;
      this.add(btn);
    }

    // セーブデータリセットボタン
    {
      var px = FlxG.width;
      var py = 8;
      var btn = new FlxButton(px, py, "DELETE", function() {
        openSubState(new DialogSubState());
      });
      btn.x -= btn.width + 8;
      this.add(btn);
    }
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
