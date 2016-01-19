package jp_2dgames.game.token;
import jp_2dgames.lib.DirUtil;
import jp_2dgames.game.token.Spike;

/**
 * 鉄球ユーティリティ
 **/
class SpikeUtil {

  // チップID
  static inline var CHIP_DONTMOVE:Int  = 1; // 動かない鉄球
  static inline var CHIP_LEFT:Int      = 2; // 左に動く
  static inline var CHIP_RIGHT:Int     = 3; // 右に動く
  static inline var CHIP_SIN_LEFT:Int  = 4; // Sinカーブ(左)
  static inline var CHIP_SIN_UP:Int    = 5; // Sinカーブ(上)
  static inline var CHIP_SIN_RIGHT:Int = 6; // Sinカーブ(右)
  static inline var CHIP_SIN_DOWN:Int  = 7; // Sinカーブ(下)

  public static function toSpikeType(id:Int):SpikeType {
    switch(id) {
      case CHIP_DONTMOVE:  return SpikeType.DontMove;
      case CHIP_LEFT:      return SpikeType.Move(Dir.Left);
      case CHIP_RIGHT:     return SpikeType.Move(Dir.Right);
      case CHIP_SIN_LEFT:  return SpikeType.Sin(Dir.Left);
      case CHIP_SIN_UP:    return SpikeType.Sin(Dir.Up);
      case CHIP_SIN_RIGHT: return SpikeType.Sin(Dir.Right);
      case CHIP_SIN_DOWN:  return SpikeType.Sin(Dir.Down);
      default:
        return SpikeType.None;
    }
  }
}
