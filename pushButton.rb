require "dxopal"
include DXOpal

# 要素の画像(サンプル)
Image.register(:PushButton, 'PushButton.png')

# -------------------------------------------
# 要素クラス
# -------------------------------------------
class PushButton < Sprite
  # 初期化処理
  def initialize
    x = 0
    y = 0
    image = Image[:PushButton]
    super(x, y, image)
  end

  # 移動処理
  def move (nextX,nextY)
      self.x = nextX
      self.y = nextY
  end
end # クラスここまで
