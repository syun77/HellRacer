package jp_2dgames.game.gui;

import jp_2dgames.lib.Snd;
import flixel.util.FlxColor;
import openfl.display.BitmapData;
import jp_2dgames.game.util.MyColor;
import flixel.text.FlxText;
import flixel.ui.FlxTypedButton;

// ボタン画像
@:bitmap("assets/images/ui/button2.png")
private class GraphicButton extends BitmapData {}


/**
 * 日本語フォントのボタン
 **/
class MyButton2 extends FlxTypedButton<FlxText> {

  // =======================================================================
  // ■各種設定
  // ボタンサイズ
  public static inline var WIDTH  = 76; // 幅
  public static inline var HEIGHT = 40; // 高さ

  // フォント
  static inline var FONT_WIDTH            = WIDTH-4; // 幅
  static inline var FONT_SIZE:Int         = 8; // フォントサイズ
  static inline var TEXT_COLOR:Int        = 0x333333; // フォントの色
  static inline var TEXT_BORDER_TYPE:Int  = FlxText.BORDER_NONE;//FlxText.BORDER_SHADOW; // 影をつける
  static inline var TEXT_BORDER_COLOR:Int = FlxColor.WHITE; // フォント縁取りの色
  static inline var SCROLL_ENABLE:Bool    = false; // スクロールしない


  // ラベルオフセット (ボタン画像からテキストの位置をずらす量)
  private static inline var LABEL_OFS_X:Int = 1;
  private static inline var LABEL_OFS_Y:Int = 6 + 2;

  // サウンド
  static inline var SOUND_ON_DOWN:String = "push"; // クリック時の音

  // 日本語フォント設定
  static inline var JP_ENABLE:Bool = false; // 使用するかどうか
  static inline var JP_PATH_FONT:String = "assets/font/PixelMplus10-Regular.ttf"; // フォントのパス
  // =======================================================================


  /**
	 * Used with public variable status, means not highlighted or pressed.
	 */
  public static inline var NORMAL:Int = 0;
  /**
	 * Used with public variable status, means highlighted (usually from mouse over).
	 */
  public static inline var HIGHLIGHT:Int = 1;
  /**
	 * Used with public variable status, means pressed (usually from mouse click).
	 */
  public static inline var PRESSED:Int = 2;

  /**
	 * Shortcut to setting label.text
	 */
  public var text(get, set):String;

  private var _enabled:Bool = true;
  public var enabled(get, set):Bool;
  private function set_enabled(b:Bool):Bool {
    _enabled = b;
    if(b) {
      // 有効
      setDefaultColor();
    }
    else {
      // 無効
      color       = MyColor.BTN_DISABLE;
      label.color = MyColor.BTN_DISABLE_LABEL;
    }
    return b;
  }
  private function get_enabled():Bool {
    return _enabled;
  }

  // ボタンにカーソルを合わせたときの詳細情報
  private var _detail:String = "";
  public var detail(get, set):String;
  private function get_detail() {
    return _detail;
  }
  private function set_detail(s:String):String {
    _detail = s;
    return _detail;
  }

  /**
   * 初期の色に戻す
   **/
  public function setDefaultColor():Void {
    color       = MyColor.BTN_DEFAULT;
    label.color = MyColor.BTN_DEFAULT_LABEL;
  }

  /**
	 * Creates a FieldFoe FlxButton object with a gray background
	 * and a callback function on the UI thread.
	 *
	 * @param	X				The X position of the button.
	 * @param	Y				The Y position of the button.
	 * @param	Text			The text that you want to appear on the button.
	 * @param	OnClick			The function to call whenever the button is clicked.
	 */
  public function new(X:Float = 0, Y:Float = 0, ?Text:String, ?OnClick:Void->Void)
  {
    super(X, Y, OnClick);
    loadGraphic(GraphicButton, true, WIDTH, HEIGHT);

    // ラベルのオフセット座標を設定
    for (point in labelOffsets)
    {
      point.set(point.x + LABEL_OFS_X, point.y + LABEL_OFS_Y);
    }

    initLabel(Text);

    // 有効にしておく
    enabled = true;

    // サウンド設定
    if(SOUND_ON_DOWN != "") {
      // 押した時
      onDown.sound = Snd.load(SOUND_ON_DOWN);
    }

    if(SCROLL_ENABLE == false) {
      // スクロールしない
      scrollFactor.set();
    }
  }

  /**
	 * Updates the size of the text field to match the button.
	 */
  override private function resetHelpers():Void
  {
    super.resetHelpers();

    if (label != null)
    {
      label.fieldWidth = label.frameWidth = Std.int(width);
      label.size = label.size; // Calls set_size(), don't remove!
    }
  }

  private inline function initLabel(Text:String):Void
  {
    label = new FlxText(x + labelOffsets[NORMAL].x, y + labelOffsets[NORMAL].y, FONT_WIDTH, Text);
    label.setFormat(null, FONT_SIZE, TEXT_COLOR, "center");
    label.alpha = labelAlphas[status];

    if(JP_ENABLE) {
      // 日本語フォント設定
      label.setFormat(JP_PATH_FONT, FONT_SIZE, TEXT_COLOR, "center");
      label.alpha = labelAlphas[status];
      label.setBorderStyle(TEXT_BORDER_TYPE, TEXT_BORDER_COLOR);
    }
  }

  private inline function get_text():String
  {
    return label.text;
  }

  private inline function set_text(Text:String):String
  {
    return label.text = Text;
  }

  override private function updateButton():Void {
    if(_enabled) {
      super.updateButton();
    }
  }

  /**
   * クリックイベントを無効にする
   **/
  public function disableClick():Void {
    onUp.callback = function() {};
  }
}
