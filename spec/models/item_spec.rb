require 'rails_helper'
RSpec.describe Item, type: :model do
  describe '出品情報の保存' do
    before do
      @item = FactoryBot.build(:item)
      @item.image = fixture_file_upload('public/images/test_image.png')
    end
    it 'すべての値が正しく入力されていれば保存できること' do
      expect(@item).to be_valid
    end
    it '出品画像が空だと保存できないこと' do
      @item.image = nil
      @item.valid?
      expect(@item.errors.full_messages).to include("画像を入力してください")
    end
    it '商品名が空だと保存できないこと' do
      @item.name = nil
      @item.valid?
      expect(@item.errors.full_messages).to include("商品名を入力してください")
    end
    it '商品の説明が空だと保存できないこと' do
      @item.item_description = nil
      @item.valid?
      expect(@item.errors.full_messages).to include("商品の説明を入力してください")
    end
    it 'カテゴリーを選択していないと保存できないこと' do
      @item.category_id = 1
      @item.valid?
      expect(@item.errors.full_messages).to include("カテゴリーを選択して下さい")
    end
    it '商品の状態を選択していないと保存できないこと' do
      @item.status_id = 1
      @item.valid?
      expect(@item.errors.full_messages).to include("商品の状態を選択して下さい")
    end
    it '配送料の負担を選択していないと保存できないこと' do
      @item.delivery_fee_id = 1
      @item.valid?
      expect(@item.errors.full_messages).to include("配送料の負担を選択して下さい")
    end
    it '発送元の地域を選択していないと保存できないこと' do
      @item.prefecture_id = 1
      @item.valid?
      expect(@item.errors.full_messages).to include("都道府県を選択して下さい")
    end
    it '発送までの日数を選択していないと保存できないこと' do
      @item.days_until_shipping_id = 1
      @item.valid?
      expect(@item.errors.full_messages).to include("発送までの日数を選択して下さい")
    end
    it 'priceが空だと保存できないこと' do
      @item.price = nil
      @item.valid?
      expect(@item.errors.full_messages).to include("価格を入力してください")
    end
    it 'priceが全角数字だと保存できないこと' do
      @item.price = '１０００'
      @item.valid?
      expect(@item.errors.full_messages).to include("価格は半角数字で入力して下さい")
    end
    it 'priceが300円未満では保存できないこと' do
      @item.price = 299
      @item.valid?
      expect(@item.errors.full_messages).to include("価格は300円以上9999999円以下に設定して下さい")
    end
    it 'priceが9,999,999円を超過すると保存できないこと' do
      @item.price = 10000000
      @item.valid?
      expect(@item.errors.full_messages).to include("価格は300円以上9999999円以下に設定して下さい")
    end
  end
end