package jp_2dgames.game.gui;
import flixel.FlxG;
import flixel.text.FlxText;
import flixel.group.FlxGroup;

/**
 * チュートリアルUI
 **/
class TutorialUI extends FlxGroup {
  public function new(cbClose:Void->Void) {

    super();

    // TODO: テキストを表示
    var px = 0;
    var py = 80;
    var txt = new FlxText(px, py, FlxG.width, "Tutorial Message");
    txt.alignment = "center";
    this.add(txt);

    // ボタン
    var btn = new MyButton2(FlxG.width/2, FlxG.height*0.7, "OK", function() {
      // ボタンを押したら閉じる
      cbClose();
    });
    btn.x -= btn.width/2;
    this.add(btn);
  }
}
