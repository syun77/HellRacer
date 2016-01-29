package jp_2dgames.game.global;

/**
 * フラグ管理
 **/
class Flags {

  // フラグの用途
  public static inline var TUTORIAL:Int = 0; // チュートリアル

  // フラグ最大数
  public static inline var MAX:Int = 32;

  public static function check(idx:Int):Bool {
    return Global.getFlags()._check(idx);
  }

  public static function on(idx:Int):Void {
    Global.getFlags()._on(idx);
  }


  // ==============================================================
  // ■メンバ変数
  var _flags:Array<Bool>;

  /**
   * コンストラクタ
   **/
  public function new() {
    _flags = new Array<Bool>();
    for(i in 0...MAX) {
      _flags.push(false);
    }
  }

  /**
   * コピー
   **/
  public function copy(src:Flags):Void {
    for(i in 0...MAX) {
      _set(i, src._check(i));
    }
  }

  /**
   * フラグチェック
   **/
  function _check(idx:Int):Bool {
    if(idx < 0 || MAX <= idx) {
      trace('Invalid Flag idx:${idx}');
      return false;
    }

    return _flags[idx];
  }

  /**
   * フラグをONにする
   **/
  function _on(idx:Int):Void {
    if(idx < 0 || MAX <= idx) {
      trace('Invalid Flag idx:${idx}');
      return;
    }

    _flags[idx] = true;
  }

  /**
   * 直接設定する
   **/
  function _set(idx:Int, b):Void {
    if(idx < 0 || MAX <= idx) {
      trace('Invalid Flag idx:${idx}');
      return;
    }

    _flags[idx] = b;
  }
}
