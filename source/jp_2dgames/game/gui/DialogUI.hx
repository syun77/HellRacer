package jp_2dgames.game.gui;

import jp_2dgames.game.util.MyColor;
import flixel.util.FlxDestroyUtil;
import flixel.FlxState;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import flixel.text.FlxText;
import flixel.FlxSprite;
import flixel.FlxG;
import flixel.group.FlxGroup;

/**
 * ダイアログ
 **/
class DialogUI extends FlxGroup {

  // ダイアログの種類
  public static inline var OK:Int      = 0; // ダイアログ
  public static inline var YESNO:Int   = 1; // Yes/Noダイアログ
  public static inline var SELECT2:Int = 2; // 2択ダイアログ
  public static inline var SELECT3:Int = 3; // 3択ダイアログ

  // 選択した項目
  public static inline var BTN_NO:Int  = 0; // いいえ
  public static inline var BTN_YES:Int = 1; // はい


  // 背景暗転を有効にするかどうか
  private static inline var ENABLE_BLACK_BG = true;

  private static inline var WINDOW_ALPHA = 0.5; // ウィンドウの透過値
  // 幅
  private static inline var FRAME_SIZE:Int = 2;
  private static inline var HEIGHT:Int = 64;

  // 3択ダイアログのオフセット座標(Y)
  private static inline var SELECT3_OFS_Y:Int = 24;

  private static inline var BTN_OFS_Y:Int = 8;
  // ボタンの間隔
  private static inline var BTN_DY:Int = MyButton2.HEIGHT + 2;
  private static inline var BTN_DX:Int = MyButton2.WIDTH + 4;

  // インスタンス
  private static var _instance:DialogUI = null;

  private static var _state:FlxState = null;

  /**
   * 開く
   **/
  public static function open(state:FlxState, type:Int, msg:String, sels:Array<String>, cbFunc:Int->Void):Void {
    _instance = new DialogUI(type, msg, sels, cbFunc);
    state.add(_instance);
    _state = state;
  }

  // ■メンバ変数

  /**
   * コンストラクタ
   **/
  public function new(type:Int, msg:String, sels:Array<String>, cbFunc:Int->Void) {
    super();

    if(ENABLE_BLACK_BG) {
      // 背景を暗転する
      var bg = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
      bg.alpha = 0.7;
      this.add(bg);
    }

    var px = FlxG.width/2;
    var py = FlxG.height/2;
    var height = HEIGHT;
    if(type == SELECT3) {
      // 広げる
      height = SELECT3_OFS_Y;
    }
    var width = Std.int(FlxG.width/3); // ウィンドウサイズを固定

    // ウィンドウ
    var frame = new FlxSprite(px-FRAME_SIZE, py - height - FRAME_SIZE);
    frame.scrollFactor.set();
    this.add(frame);
    var spr = new FlxSprite(px, py - height);
    spr.scrollFactor.set();
    this.add(spr);

    // メッセージ
    var text = new FlxText(px-width, py - 48, width*2);
//    text.setFormat(Reg.PATH_FONT, Reg.FONT_SIZE_S);
    text.setFormat(null, 12);
    // 中央揃え
    text.alignment = "center";
    text.text = msg;
    text.scrollFactor.set(0, 0);
    this.add(text);

    // ウィンドウサイズを設定
    frame.makeGraphic(Std.int(width + FRAME_SIZE) * 2, (height + FRAME_SIZE) * 2, FlxColor.WHITE);
    frame.x -= width;
    frame.alpha = WINDOW_ALPHA;
    frame.scale.set(0.2, 1);
    FlxTween.tween(frame.scale, {x:1}, 0.5, {ease:FlxEase.expoOut});

    spr.makeGraphic(Std.int(width * 2), height * 2, FlxColor.WHITE);
    spr.color = MyColor.MESSAGE_WINDOW;
    spr.x -= width;
    spr.alpha = 0.5;
    spr.scale.set(0.2, 1);
    FlxTween.tween(spr.scale, {x:1}, 0.5, {ease:FlxEase.expoOut});

    // 選択肢
    var py2 = FlxG.height / 2 + BTN_OFS_Y;
    var labels:Array<String> = [];
    switch(type) {
      case OK:
        labels = ["OK"];

      case YESNO:
        labels = [
//          UIMsg.get(UIMsg.NO)
//          UIMsg.get(UIMsg.YES),
          "No",
          "Yes"
        ];
      case SELECT2:
        labels = sels;

      case SELECT3:
        labels = sels;
    }

    // 選択肢ボタン登録
    var idx:Int = 0;
    var dx:Int = 0;
    var dy:Int = BTN_DY;
    if(labels.length == 2) {
      // 2つの場合は特殊処理
      px -= BTN_DX / 2;
      dx = BTN_DX;
      dy = 0;
    }

    for(str in labels) {
      var btnID = idx;
      var btn = new MyButton2(px, py2, str, function() {

        // 決定した
        _pressButton(cbFunc, btnID);
      });
      // センタリング
      btn.x -= btn.width / 2;
      this.add(btn);
      px += dx;
      py2 += dy;

      idx++;

      btn.scrollFactor.set(0, 0);
    }
  }

  /**
   * ボタンを押した
   **/
  private function _pressButton(cbFunc:Int->Void, btnID:Int):Void {
    cbFunc(btnID);

    // ウィンドウを消す
    _instance.kill();
    _state.remove(_instance);
    _state = null;
    _instance = FlxDestroyUtil.destroy(_instance);
  }
}
