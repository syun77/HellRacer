package jp_2dgames.game.util;

// グローバル
import flixel.util.FlxSave;
import openfl.filesystem.File;
import haxe.Json;

private class _Global {
  public var hi_score:Int;
  public function new() {
  }
  // セーブ
  public function save() {
    hi_score = Global.getHiScore();
  }
  // ロード
  public function load(data:Dynamic) {
    Global.setHiScore(data.hi_score);
  }
}

// セーブデータ
private class _SaveData {
  public var global:_Global;

  public function new() {
    global = new _Global();
  }

  // セーブ
  public function save() {
    global.save();
  }
  // ロード
  public function load(data:Dynamic) {
    global.load(data.global);
  }
}

/**
 * セーブ処理
 **/
class Save {
  /**
   * セーブする
   * @param bToText テキストへの保存を行うかどうか
   * @param bLog    ログ出力を行うかどうか
   **/
  public static function save(bToText:Bool, bLog:Bool):Void {

    var data = new _SaveData();
    data.save();

    var str = Json.stringify(data);

    if(bToText) {
      // テキストへ保存する
      #if neko
      sys.io.File.saveContent(Reg.PATH_SAVE, str);
      if(bLog) {
        trace("save ----------------------");
        trace(data);
      }
      #end
    }
    else {
      // セーブ領域へ書き込み
      var saveutil = new FlxSave();
      saveutil.bind("SAVEDATA");
      saveutil.data.playdata = str;
      saveutil.flush();
    }
  }

  /**
   * ロードする
   * @param bFromText テキストから読み込みを行うかどうか
   * @param bLog      ログ出力を行うかどうか
   **/
  public static function load(bFromText:Bool, bLog:Bool):Void {
    var str = "";
    #if neko
    str = sys.io.File.getContent(Reg.PATH_SAVE);
    if(bLog) {
      trace("load ----------------------");
      trace(str);
    }
    #end

    var saveutil = new FlxSave();
    saveutil.bind("SAVEDATA");
    if(bFromText) {
      // テキストファイルからロードする
      var data = Json.parse(str);
      var s = new _SaveData();
      s.load(data);
    }
    else {
      var data = Json.parse(saveutil.data.playdata);
      var s = new _SaveData();
      s.load(data);
    }
  }

  /**
   * セーブデータを消去する
   **/
  public static function erase():Void {
    var saveutil = new FlxSave();
    saveutil.bind("SAVEDATA");
    saveutil.erase();
  }

  public static function isContinue():Bool {
    var saveutil = new FlxSave();
    saveutil.bind("SAVEDATA");
    if(saveutil.data == null) {
      return false;
    }
    if(saveutil.data.playdata == null) {
      return false;
    }

    return true;
  }
}
