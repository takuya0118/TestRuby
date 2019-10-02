require "dxopal"
include DXOpal
require_remote "pushButton.rb"
require_remote "cat.rb"

# 読み込みたい音声を登録する
Sound.register(:buySound, 'Water.mp3')
Sound.register(:buySound2, 'Bird.mp3')
Sound.register(:buySound3, 'Atari.mp3')

# -------------------------------------------
# メイン処理は、ここから開始
# -------------------------------------------
imteArray = []
Window.load_resources do
  # ボタン配置
  pushButton1 = PushButton.new
  pushButton2 = PushButton.new
  pushButton2.move(0,50)
  pushButton3 = PushButton.new
  pushButton3.move(0,100)

  # 管理リストに追加
  imteArray.push(pushButton1)
  imteArray.push(pushButton2)
  imteArray.push(pushButton3)
    
  #猫配置
  animal = Cat.new


    # -------------------------------------------
    # メインループ
    # -------------------------------------------
    Window.loop do

        # マウス位置(x座標、y座標)の取得
        mouse_x = Input.mouse_pos_x
        mouse_y = Input.mouse_pos_y
        animal.Draw

        # マウスアップ時
        if Input.mouse_push?(M_LBUTTON) then

          # 効果音を停止
          Sound[:buySound].stop
          Sound[:buySound2].stop
          Sound[:buySound3].stop

          # 効果音を鳴らす
          if mouse_x < 60 then
            if mouse_y < 50 then

              # サウンド1の再生
              Sound[:buySound].play

              # アニメーション再生
              animal.StartAnimationCase1
            elsif mouse_y < 100 then

              # サウンド2の再生
              Sound[:buySound2].play
              # アニメーション再生
              animal.StartAnimationCase2
            elsif mouse_y < 150 then

              # サウンド3の再生
              Sound[:buySound3].play
            end
          end
        end

        # アイテム描画(描画順番に注意★)
        self.drawItem(imteArray)

        # デバッグ表示
        self.debugDraw(mouse_x,mouse_y)
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
# デバッグ出力
# ------------------------------
def debugDraw(mouse_x,mouse_y)
  Window.draw_font(0, 280, mouse_x, Font.default, color: C_WHITE)
  Window.draw_font(0, 300, mouse_y, Font.default, color: C_WHITE)
end
