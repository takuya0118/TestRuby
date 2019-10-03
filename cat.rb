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
    @x = 220
    @y = 220

    # デフォルトの画像
    @catDefault = Image[:CatDefault]

    # アニメーション用画像
    @catAnimation1 = Image[:Animation1].slice_tiles(4, 4)
    @catAnimation2 = Image[:Animation2].slice_tiles(4, 2)
    @catAnimation3 = Image[:Animation1].slice_tiles(4, 4)

    # アニメーション用変数
    @cnt = 0
    @cnt2 = 0
    @cnt3 = 0
    @index_max = 15
    @index_max2 = 8
    @index_max3 = 15
    @isAnimation = false
    @isAnimation2 = false
    @isAnimation3 = false
    @walkToRight = false
  end

  # 場所変更
  def changeXY (xx,yy)
    @x = xx
    @y = yy
  end

  # 描画
  def Draw

    # アニメーション3描画
    if @isAnimation3 == true then
      @cnt3 = @cnt3 + 0.8
      index3 = @cnt3.to_i % @index_max3
      Window.draw(@x, @y, @catAnimation3[index3])

      if index3 > 13 then
        @isAnimation3 = false
      end
      return
    end

    # アニメーション2描画    
    if @isAnimation2 == true then
      @cnt2 = @cnt2 + 0.3
      index2 = @cnt2.to_i % @index_max2
      Window.draw(@x, @y, @catAnimation2[index2])

      if index2 > 6 then
        @isAnimation2 = false
      end
      return
    end

    # アニメーション1描画
    if @isAnimation == true then
      @cnt = @cnt + 0.1
      index = @cnt.to_i % @index_max
      Window.draw(@x, @y, @catAnimation1[index])

      if index > 13 then
        @isAnimation = false
      end
      return
    end

    # 通常の描画
    if @isAnimation == false then
      Window.draw(@x, @y, @catDefault)
    end
  end

  # アニメーション開始
  def StartAnimation1
    @isAnimation = true
  end
  def StartAnimation2
    @isAnimation2 = true
  end
  def StartAnimation3
    @isAnimation3 = true
  end

  # 描画
  def Walking

    # 水平方向の移動を繰り返す
    if @walkToRight == true then
      @x = @x + 0.3
    else
      @x = @x - 0.3
    end

    # 方向転換
    if @walkToRight == true then
      if @x > 450 then
        @walkToRight = false
      end
    else
      if @x < 50 then
        @walkToRight = true
      end
    end

    @cnt = @cnt + 0.2
    index = @cnt.to_i % @index_max
    Window.draw(@x, @y, @catAnimation1[index])
  end

end # クラスここまで
