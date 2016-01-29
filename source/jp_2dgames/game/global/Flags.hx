package jp_2dgames.game.global;

/**
 * フラグ管理
 **/
class Flags {
  public static inline var MAX:Int = 32;

  public function check(idx:Int):Bool {
    return Global.getFlags().check(idx);
  }

  public function on(idx:Int):Void {
    Global.getFlags().on(idx);
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
      _set(i, src.check(i));
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
