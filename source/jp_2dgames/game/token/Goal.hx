package jp_2dgames.game.token;

/**
 * ゴールオブジェクト
 **/
class Goal extends Token {

  /**
   * コンストラクタ
   **/
  public function new() {
    super();

    // ゴール画像の読み込み
    loadGraphic(Reg.PATH_IMAGE_GOAL);

    // 座標を設定
    x = Wall.CHIP_LEFT;
  }
}
