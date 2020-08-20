class Item < ApplicationRecord
  belongs_to :user
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
  with_options presence: true, numericality: { other_than: 1, message: "Select"} do
    validates :category_id
    validates :status_id
    validates :delivery_fee_id
    validates :prefecture_id
    validates :days_until_shipping_id
  end
  PRICE_REGEX =  /\A[0-9]+\z/
  with_options presence: true do
  validates :name
  validates :item_description
  validates :price,
            format: {with: PRICE_REGEX, message: "Half-width number"}
  end
  validates :price, numericality: { only_integer: true, greater_than_or_equal_to: 300, less_than_or_equal_to: 9999999, message: "is out of setting range" } 
end
