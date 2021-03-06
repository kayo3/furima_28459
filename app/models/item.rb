class Item < ApplicationRecord
  belongs_to :user
  has_one :order
  extend ActiveHash::Associations::ActiveRecordExtensions
  has_one_attached :image
  belongs_to_active_hash :category
  belongs_to_active_hash :status
  belongs_to_active_hash :delivery_fee
  belongs_to_active_hash :prefecture
  belongs_to_active_hash :days_until_shipping
  #バリデーションの設定
  #空の投稿を保存できないようにする
  #ジャンルの選択が「--」の時は保存できないようにする
  with_options presence: true, numericality: { other_than: 1, message: "を選択して下さい"} do
    validates :category_id
    validates :status_id
    validates :delivery_fee_id
    validates :prefecture_id
    validates :days_until_shipping_id
  end
  PRICE_REGEX =  /\A[0-9]+\z/
  with_options presence: true do #prisense: true で弾かれてしまうとその後記述したエラー文は適用されないので注意。
  validates :image
  validates :name
  validates :item_description
  validates :price
  end
  validates :price, numericality: { only_integer: true, greater_than_or_equal_to: 300, less_than_or_equal_to: 9999999, message: "は300円以上9999999円以下に設定して下さい" } 
  validates :price, numericality: { with: PRICE_REGEX, message: "は半角数字で入力して下さい" }
end
