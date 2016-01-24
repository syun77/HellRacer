package jp_2dgames.game.util;
import flixel.util.FlxColor;

/**
 * 色関連の情報
 **/
class MyColor {
  // ■アイテムリスト
  // 選択可能
  public static inline var LISTITEM_ENABLE:Int = 0x006666;
  // 選択不可
  public static inline var LISTITEM_DISABLE:Int = 0x003333;
  // テキストの色
  public static inline var LISTITEM_TEXT:Int = 0x99FFCC;
  public static inline var CURSOR:Int = FlxColor.YELLOW;

  public static inline var COMMAND_FRAME:Int   = 0x00CCCC;
  public static inline var COMMAND_CURSOR:Int  = 0x33CCCC;
  public static inline var COMMAND_DISABLE:Int = 0x999999;
  public static inline var COMMAND_TEXT_SELECTED:Int = 0x000066;
  public static inline var COMMAND_TEXT_UNSELECTED:Int = 0x99FFCC;

  public static inline var DETAIL_FRAME:Int = 0x000033;
  public static inline var MESSAGE_WINDOW:Int = 0x000033;

  public static inline function strToColor(str:String):Int {
    switch(str) {
      case "white": return FlxColor.WHITE;
      case "red": return FlxColor.PINK;
      case "green": return FlxColor.LIME;
      case "blue": return FlxColor.AQUAMARINE;
      case "yellow": return FlxColor.YELLOW;
      case "orange": return FlxColor.WHEAT;
      default:
        return FlxColor.BLACK;
    }
  }

  // ■ボタン
  // ボタン(デフォルト)
  public static inline var BTN_DEFAULT       = FlxColor.WHITE;
  public static inline var BTN_DEFAULT_LABEL = FlxColor.BLACK;

  // ボタン(無効)
  public static inline var BTN_DISABLE       = FlxColor.GRAY;
  public static inline var BTN_DISABLE_LABEL = FlxColor.BLACK;

  // ボタン(装備)
  public static inline var BTN_EQUIP         = FlxColor.MAUVE;
  public static inline var BTN_EQUIP_LABEL   = FlxColor.BLACK;

  // ボタン(消費アイテム)
  public static inline var BTN_CONSUME       = FlxColor.LIME;
  public static inline var BTN_CONSUME_LABEL = FlxColor.BLACK;

  // ボタン(ショップ・次のフロア)
  public static inline var BTN_SHOP          = FlxColor.YELLOW;
  public static inline var BTN_SHOP_LABEL    = FlxColor.BLACK;

  // ボタン(キャンセル)
  public static inline var BTN_CANCEL        = FlxColor.SILVER;
  public static inline var BTN_CANCEL_LABEL  = FlxColor.BLACK;

  // ■数値
  // ダメージ
  public static inline var NUM_DAMAGE = FlxColor.SILVER;
  // 回復
  public static inline var NUM_RECOVER = FlxColor.LIME;
  // MISS
  public static inline var NUM_MISS   = FlxColor.AQUAMARINE;

  // パネル
  public static inline var PANEL_NON_ACTIVE = FlxColor.BLACK;
  public static inline var PANEL_ACTIVE = FlxColor.AQUAMARINE;
  public static inline var PANEL_DAMAGE = FlxColor.SALMON;
  public static inline var PANEL_BADSTATUS = ASE_PURPLE;

  // ■敵の色
  public static inline var ENEMY_NON_ACTIVE:Int = FlxColor.CHARCOAL;


  // Asepriteカラーセット
  public static inline var ASE_BLACK:Int     = 0xFF000000; // 黒
  public static inline var ASE_LAMPBLACK:Int = 0xFF222034; // 濃い黒
  public static inline var ASE_TAUPE:Int     = 0xFF45283C; // 黒
  public static inline var ASE_BROWN:Int     = 0xFF663931; // 茶色
  public static inline var ASE_MAROON:Int    = 0xFF8F563B; // 赤茶色
  public static inline var ASE_ORANGE:Int    = 0xFFDF7126; // オレンジ
  public static inline var ASE_SALMON:Int    = 0xFFD9A066; // オレンジピンク
  public static inline var ASE_PINK:Int      = 0xFFEEC39A; // 肌色
  public static inline var ASE_YELLOW:Int    = 0xFFFBF236; // 黄色
  public static inline var ASE_LIME:Int      = 0xFF99E550; // 黄緑
  public static inline var ASE_LIMEGREEN:Int = 0xFF6ABE30; // 濃い黄緑
  public static inline var ASE_GREEN:Int     = 0xFF37946E; // 緑
  public static inline var ASE_DARKGREEN:Int = 0xFF4B692F; // 暗い緑
  public static inline var ASE_DARKBROWN:Int = 0xFF524B24; // 暗い茶色
  public static inline var ASE_DARKNAVY:Int  = 0xFF323C39; // 暗い紺色
  public static inline var ASE_NAVY:Int      = 0xFF3F3F74; // 濃い紺色
  public static inline var ASE_TEAL:Int      = 0xFF306082; // 青緑
  public static inline var ASE_BLUE:Int      = 0xFF5B6EE1; // 青
  public static inline var ASE_SKYBLUE:Int   = 0xFF639BFF; // 薄い青色
  public static inline var ASE_CYAN:Int      = 0xFF5FCDE4; // 水色
  public static inline var ASE_LIGHTCYAN:Int = 0xFFCBDBFC; // 薄い水色
  public static inline var ASE_WHITE:Int     = 0xFFFFFFFF; // 白
  public static inline var ASE_FRENCHGRAY:Int= 0xFF9BADB7; // 青みがかった灰色
  public static inline var ASE_DARKGRAY:Int  = 0xFF847E87; // 明るい灰色
  public static inline var ASE_GRAY:Int      = 0xFF696A6A; // 灰色
  public static inline var ASE_CHARCOAL:Int  = 0xFF595652; // 石炭色
  public static inline var ASE_PURPLE:Int    = 0xFF76428A; // 紫
  public static inline var ASE_CRIMSON:Int   = 0xFFAC3232; // 濃い赤
  public static inline var ASE_RED:Int       = 0xFFD95763; // 赤
  public static inline var ASE_MAGENTA:Int   = 0xFFD77BBA; // 明るい赤紫色
  public static inline var ASE_DRAKKHAKI:Int = 0xFF8F974A; // 暗い黄土色
  public static inline var ASE_OLIVE:Int     = 0xFF8A8F30; // 暗い黄色
}

