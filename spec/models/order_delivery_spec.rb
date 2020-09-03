require 'rails_helper'

RSpec.describe OrderDelivery, type: :model do
  describe '購入情報の保存' do
    before do
      @order_delivery = FactoryBot.build(:order_delivery)
    end
    it 'すべての値が正しく入力されていれば保存できること' do
      expect(@order_delivery).to be_valid
    end
    it 'postal_codeが空だと保存できないこと' do
      @order_delivery.postal_code = nil
      @order_delivery.valid?
      expect(@order_delivery.errors.full_messages).to include("郵便番号を入力してください")
    end
    it 'postal_codeが半角のハイフンを含んだ正しい形式でないと保存できないこと' do
      @order_delivery.postal_code = '1234567'
      @order_delivery.valid?
      expect(@order_delivery.errors.full_messages).to include("郵便番号は「-」（ハイフン）を含む半角数字で入力してください")
    end
    it 'prefectureを選択していないと保存できないこと' do
      @order_delivery.prefecture_id = 1
      @order_delivery.valid?
      expect(@order_delivery.errors.full_messages).to include("都道府県を選択してください")
    end
    it 'cityが空だと保存できないこと' do
      @order_delivery.city = nil
      @order_delivery.valid?
      expect(@order_delivery.errors.full_messages).to include("市区町村を入力してください")
    end
    it 'blockが空だと保存できないこと' do
      @order_delivery.block = nil
      @order_delivery.valid?
      expect(@order_delivery.errors.full_messages).to include("番地を入力してください")
    end
    it 'tel_numberが空だと保存できないこと' do
      @order_delivery.tel_number = nil
      @order_delivery.valid?
      expect(@order_delivery.errors.full_messages).to include("電話番号を入力してください")
    end
    it 'tel_numberは半角数字11桁でないと保存できないこと' do
      @order_delivery.tel_number = '090-1234-5678910'
      @order_delivery.valid?
      expect(@order_delivery.errors.full_messages).to include("電話番号は半角数字のみで入力してください")
    end
    it 'buildingは空でも保存できること' do
      @order_delivery.building = nil
      expect(@order_delivery).to be_valid
    end
    it 'tokenが空だと保存できないこと' do
      @order_delivery.token = nil
      @order_delivery.valid?
      expect(@order_delivery.errors.full_messages).to include("カード情報を入力してください")
    end
  end
end