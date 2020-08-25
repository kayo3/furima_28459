class Delivery < ApplicationRecord
  belongs_to :order
  belongs_to_active_hash :prefecture

  with_options presence: true do
    validates :postal_code
    validates :prefecture_id
    validates :city
    validates :block
    validates :building
    validates :tel_number
    validates :order_id
  end
  POSTAL_CODE_REGEX = /\A\d{3}[-]\d{4}\z/
  TEL_NUMBER_REGEX = /\A\d{10,11}\z/
  validates :postal_code, numericality: { with: POSTAL_CODE_REGEX, message: "Postal code Input correctly" }
  validates :tel_number,  numericality: { with: TEL_NUMBER_REGEX, message: "Tel number Input correctly" }
end
