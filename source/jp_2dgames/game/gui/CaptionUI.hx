package jp_2dgames.game.gui;
import jp_2dgames.game.global.Global;
import flixel.util.FlxColor;
import flixel.text.FlxText;
import flixel.FlxSprite;
import flixel.FlxG;
import flixel.group.FlxSpriteGroup;

/**
 * キャプションUI
 **/
class CaptionUI extends FlxSpriteGroup {

  static inline var HEIGHT = 24;
  static inline var SCORE_Y = 32;

  var _bg:FlxSprite;
  var _txt:FlxText;

  /**
   * コンストラクタ
   **/
  public function new() {
    var BASE_X = 0;
    var BASE_Y = FlxG.height/3; // 画面1/3あたり
    super(BASE_X, BASE_Y);

    var WIDTH = FlxG.width;
    _bg = new FlxSprite(0, 0);
    _bg.makeGraphic(WIDTH, HEIGHT, FlxColor.BLACK);
    _bg.alpha = 0.5;
    this.add(_bg);

    _txt = new FlxText(0, 0, WIDTH, "", 20);
    _txt.setBorderStyle(FlxText.BORDER_OUTLINE);
    _txt.alignment = "center";
    this.add(_txt);

    // スクロール無効
    scrollFactor.set();

    // 初期状態は非表示
    visible = false;
  }

  /**
   * キャプションの表示
   * @param msg    表示するメッセージ
   **/
  public function show(msg:String):Void {
    _txt.text = msg;
    visible = true;
  }

  /**
   * キャプションを非表示
   **/
  public function hide():Void {
    visible = false;
  }
}
