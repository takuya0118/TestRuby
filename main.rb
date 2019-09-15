require "dxopal"
include DXOpal
require_remote "item.rb"

# -------------------------------------------
# メイン処理は、ここから開始
# -------------------------------------------
imteArray = []
Window.load_resources do
  mouse_areaIdx = 0

  # パズル要素の初期配置
  item1 = PuzzleItem.new
  item2 = PuzzleItem.new
  item2.move(0,225)
  item3 = PuzzleItem.new
  item3.move(225,0)
 
  # 管理リストに追加
  imteArray.push(item1)
  imteArray.push(item2)
  imteArray.push(item3)

    # -------------------------------------------
    # メインループ
    # -------------------------------------------
    Window.loop do

        # マウス位置(x座標、y座標)の取得
        mouse_x = Input.mouse_pos_x
        mouse_y = Input.mouse_pos_y

        # ウィンドウ背景の描画
        Window.draw_box_fill(0, 0, Window.width, Window.height, [10, 10, 10])

        # マウスアップ時
        if Input.mouse_push?(M_LBUTTON) then

          # マウスアップ座標に該当するエリア番号を取得
          mouse_areaIdx = self.getMousePosAreaIdx(mouse_x,mouse_y)

          # 配置済み番号リストを取得
          imteArrayNew = self.getAreaIndexArray(imteArray)

          # 空き地を確認し、移動できるか試す
          for areaIdx in 0..3 do

            # 含まれていない場合は、空き地
            if self.isContaionArea(imteArrayNew,areaIdx) == false then

              # そこへ移動可能か？
              imteArray.each do | item |
                idx = item.getPosIdx
                if idx.to_i == mouse_areaIdx then
                  self.itemMove(item,areaIdx)
                end
              end
              break
            end            
          end
        end

        # アイテム描画(描画順番に注意★)
        self.drawItem(imteArray)
        self.drawBorderRect

        # デバッグ表示
        self.debugDraw(mouse_areaIdx,mouse_x,mouse_y)
  end #End Window.loop do
end #End Window.load_resources do


# ------------------------------
# パズル要素の描画
# ------------------------------
def drawItem(itemArray)
  itemArray.each do | item |
    item.draw
  end
end

# ------------------------------
# 枠線の描画
# ------------------------------
def drawBorderRect
  w = 225; h = 225
  2.times do |row|
    2.times do |col|
      x = 0 + col*w
      y = 0 + row*h
      Window.draw_box(x, y, x+w, y+h, C_WHITE)
      end
  end
end

# ------------------------------
# 番号がリストにあるか
# ------------------------------
def isContaionArea(itemArray,targetIdx)
  itemArray.each do | num |
    if targetIdx == num then
      return true
    end
  end
  return false
end

# ------------------------------
# エリア番号リスト取得
# ------------------------------
def getAreaIndexArray(itemArray)
  itemArrayNew = []
  itemArray.each do | item |
    i = item.getPosIdx
    itemArrayNew.push(i.to_i)
  end
  return itemArrayNew
end

# ------------------------------
# マウスアップ位置のエリア番号取得
# ------------------------------
def getMousePosAreaIdx(mouse_x,mouse_y)
  xIdx = mouse_x / 225
  yIdx = mouse_y / 225
  areaIdx = xIdx.to_i * 1 + yIdx.to_i * 2
  return areaIdx
end

# ------------------------------
# パズル要素の移動
# ------------------------------
def itemMove(item,nextAreaIdx)
  case nextAreaIdx
    when 0 then
      item.move(0,0)
    when 1 then
      item.move(225,0)
    when 2 then
      item.move(0,225)
    when 3 then
      item.move(225,225)
  end
end

# ------------------------------
# デバッグ出力
# ------------------------------
def debugDraw(mouse_areaIdx,mouse_x,mouse_y)  
  #Window.draw_font(0, 0, xx, Font.default, color: C_WHITE)
  #Window.draw_font(0, 20, yy, Font.default, color: C_WHITE)
  Window.draw_font(0, 60, mouse_areaIdx, Font.default, color: C_WHITE)
  Window.draw_font(0, 80, mouse_x, Font.default, color: C_WHITE)
  Window.draw_font(0, 100, mouse_y, Font.default, color: C_WHITE)
end
