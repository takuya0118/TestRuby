require "dxopal"
include DXOpal

# パズル要素の画像(サンプル)
Image.register(:item1, 'images/item1.png')

# -------------------------------------------
# パズル要素クラス
# -------------------------------------------
class PuzzleItem < Sprite

  # 初期化処理
  def initialize
    x = 0
    y = 0
    image = Image[:item1]
    super(x, y, image)
  end

  # 移動可能か
  def canMoveR
    return self.x == 0
  end
  def canMoveL
    return self.x == 225
  end
  def canMoveUp
    return self.y == 225
  end
  def canMoveDn
    return self.y == 0
  end

  # 指定した座標に移動可能か
  def canMove(nextX,nextY)

    # 水平方向の移動か？
    if self.y == nextY then
      # 右に移動可能か
      if canMoveR then
        if nextX == 225 then
          return true
        end
      end

      # 左に移動可能か
      if canMoveL then
        if nextX == 0 then
          return true
        end
      end
    end

    # 垂直方向の移動か？
    if self.x == nextX then
      # 上に移動可能か
      if canMoveUp then
        if nextY == 0 then
          return true
        end
      end

      # 下に移動可能か
      if canMoveDn then
        if nextY == 225 then
          return true
        end
      end
    end

    return false
  end

  # 移動処理
  def move (nextX,nextY)
    if canMove(nextX,nextY) then
      self.x = nextX
      self.y = nextY
    end
  end

  # 現在地の取得
  def getPosIdx
    xxx = self.x / 225
    yyy = self.y / 225
    return xxx * 1 + yyy * 2
  end
end # クラスここまで
