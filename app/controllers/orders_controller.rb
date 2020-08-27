class OrdersController < ApplicationController
  before_action :find_item
  
  def index
    @order_delivery = OrderDelivery.new
    unless user_signed_in?
      redirect_to new_user_session_path
    end
  end

  def create
    @order_delivery = OrderDelivery.new(order_delivery_params)
    if @order_delivery.valid?
      pay_item 
      @order_delivery.save
      return redirect_to root_path
    else
      render :index
    end
  end

private

  def order_delivery_params
    params.require(:order_delivery).permit(:token, :postal_code, :prefecture_id, :city, :block, :building, :tel_number,:order_id).merge(user_id: current_user.id, item_id: @item.id)
  end
  
  def find_item
    @item = Item.find(params[:item_id])
  end
  
  def pay_item
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]     # PAY.JPテスト秘密鍵
    Payjp::Charge.create(
      amount: @item.price,                      # 商品の値段
      card: params[:order_delivery][:token],    # カードトークン
      currency:'jpy'                            # 通貨の種類(日本円)
    )
  end
end