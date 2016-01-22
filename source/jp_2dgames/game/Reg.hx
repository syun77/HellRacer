package jp_2dgames.game;

import jp_2dgames.game.global.Global;
import jp_2dgames.lib.TextUtil;
class Reg {
  // 車
  public static inline var PATH_IMAGE_CAR = "assets/images/car.png";
  public static inline var PATH_IMAGE_CAR_RED = "assets/images/car_red.png";
  // 背景
  public static inline var PATH_IMAGE_BG = "assets/images/road.png";
  // ハンドルUI
  public static inline var PATH_IMAGE_HANDLE = "assets/images/handle.png";
  // アイテム・スコア
  public static inline var PATH_IMAGE_ITEM_SCORE = "assets/images/point.png";
  // エフェクト
  public static inline var PATH_EFFECT = "assets/images/effect.png";
  // タイトル画面
  public static inline var PATH_IMAGE_TITLE = "assets/images/title.png";
  // キャラクタータイルセット
  public static inline var PATH_IMAGE_CHAR_SET = "assets/images/charset.png";

  // セーブデータ保存先
  public static inline var PATH_SAVE = "/Users/syun/Desktop/HellRacer/save.txt";


  // プレイヤー初速
  public static inline var SPEED_INIT:Float = 50.0;

  // マップデータのパス
  public static function getMapData(id:Int):String {
    var map = TextUtil.fillZero(id, 3);
    return 'assets/data/levels/${map}.tmx';
  }

  // 固定マップデータのパス
  public static function getFixedMapPath():String {
    var map = TextUtil.fillZero(Global.getLevel(), 3);
    return 'assets/data/levels/fixed_${map}.tmx';
  }
}