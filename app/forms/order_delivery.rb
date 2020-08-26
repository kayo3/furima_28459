class OrderDelivery

  include ActiveModel::Model
  attr_accessor :user_id, :item_id, :postal_code, :prefecture_id, :city, :block, :building, :tel_number
  # Deliveryモデルのバリデーションを切り出し
  with_options presence: true do
    validates :postal_code
    validates :prefecture_id
    validates :city
    validates :block
    validates :building
    validates :tel_number
  end
  POSTAL_CODE_REGEX = /\A\d{3}[-]\d{4}\z/
  TEL_NUMBER_REGEX = /\A\d{10,11}\z/
  validates :postal_code, format: { with: POSTAL_CODE_REGEX, message: "Input correctly" } 
  validates :tel_number,  numericality: { with: TEL_NUMBER_REGEX, message: "Input correctly" } #numericality:は数値のみを許可する正規表現

  def save
    # オーダーの情報を保存し、「@order」という変数に入れる
    @order = Order.create(user_id: user_id, item_id: item_id)  # attr_accessorと変数の記述が同じでないといけない
    # 配送先の情報を保存
    Delivery.create(postal_code: postal_code, prefecture_id: prefecture_id, city: city, block: block, building: building,tel_number: tel_number, order_id: @order.id)
  end
end