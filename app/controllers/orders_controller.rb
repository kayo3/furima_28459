class OrdersController < ApplicationController
  before_action :find_item
  
  def index
    # @item = Item.find(params[:item_id])
    unless user_signed_in?
      redirect_to new_user_session_path
    end
  end

  def create
    @perchase = OrderDelivery.new(perchase_params)
    if @perchase.valid?
      pay_item 
      @perchase.save
      return redirect_to root_path
    else
      render :index
    end
  end

private

  def perchase_params
    params.permit(:item_id, :postal_code, :prefecture_id, :city, :block, :building, :tel_number,:order_id).merge(user_id: current_user.id)
  end
  
  def find_item
    @item = Item.find(params[:item_id])
  end
  
  def pay_item
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]  # PAY.JPテスト秘密鍵
    Payjp::Charge.create(
      amount: @item.price,  # 商品の値段
      card: params[:token],    # カードトークン
      currency:'jpy'                 # 通貨の種類(日本円)
    )
  end
end