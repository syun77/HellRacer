package jp_2dgames.game.token;
import jp_2dgames.game.token.Spike;

/**
 * 鉄球ユーティリティ
 **/
class SpikeUtil {

  // チップID
  static inline var CHIP_DONTMOVE:Int  = 1; // 動かない鉄球
  static inline var CHIP_LEFT:Int      = 2; // 左に動く
  static inline var CHIP_RIGHT:Int     = 3; // 右に動く

  public static function toSpikeType(id:Int):SpikeType {
    switch(id) {
      case CHIP_DONTMOVE:  return SpikeType.DontMove;
      case CHIP_LEFT:      return SpikeType.Left;
      case CHIP_RIGHT:     return SpikeType.Right;
      default:
        return SpikeType.None;
    }
  }
}
