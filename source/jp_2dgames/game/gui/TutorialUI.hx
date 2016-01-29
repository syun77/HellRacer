package jp_2dgames.game.gui;
import flixel.group.FlxSpriteGroup;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import flixel.FlxSprite;
import flixel.FlxG;
import flixel.text.FlxText;
import flixel.group.FlxGroup;

/**
 * チュートリアルUI
 **/
class TutorialUI extends FlxSpriteGroup {
  public function new(cbClose:Void->Void) {

    super();

    // 暗転背景
    var bg = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
    bg.alpha = 0.0;
    FlxTween.tween(bg, {alpha:0.5}, 1, {ease:FlxEase.expoOut});
    this.add(bg);

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

    // スクロール無効
    scrollFactor.set();
  }
}
