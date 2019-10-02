require "dxopal"
include DXOpal

# デフォルト画像
Image.register(:CatDefault, 'CatDefault.png')

# アニメーション用画像
Image.register(:Animation1, 'CatAnimation1.png')
Image.register(:Animation2, 'CatAnimation2.png')

# -------------------------------------------
# 要素クラス
# -------------------------------------------
class Cat
  # 初期化処理
  def initialize

    # 最初の座標
    @x = 200
    @y = 200

    # デフォルトの画像
    @catDefault = Image[:CatDefault]

    # アニメーション用画像
    @catAnimation1 = Image[:Animation1].slice_tiles(4, 4)
    @catAnimation2 = Image[:Animation2].slice_tiles(4, 2)

    # アニメーション用変数
    @cnt = 0
    @index_max = 15
    @isAnimation = false

    @cnt2 = 0
    @index_max2 = 8
    @isAnimation2 = false
  end

  # 描画
  def Draw
    # アニメーション2描画
    if @isAnimation2 == true then
      @cnt2 = @cnt2 + 0.3
      index2 = @cnt2.to_i % @index_max2
      Window.draw(@x, @y, @catAnimation2[index2])

      if index2 > 6 then
        @isAnimation2 = false
      end

    # アニメーション1描画
    elsif @isAnimation == true then
      @cnt = @cnt + 0.8
      index = @cnt.to_i % @index_max
      Window.draw(@x, @y, @catAnimation1[index])

      if index > 13 then
        @isAnimation = false
      end
    elsif @isAnimation == false then

      # 通常の描画
      Window.draw(@x, @y, @catDefault)
    end
  end

  # アニメーション開始
  def StartAnimationCase1
    @isAnimation = true
  end

  # アニメーション開始
  def StartAnimationCase2
    @isAnimation2 = true
  end
end # クラスここまで
