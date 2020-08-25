class OrdersController < ApplicationController
  def index
    @item = Item.find(params[:item_id])
    unless user_signed_in?
      redirect_to new_user_session_path
    end
  end

  def create
    @perchase = OrderDelivery.new(perchase_params)
    if @perchase.save
      redirect_to root_path
    else
      render :index
    end
  end

private

  def perchase_params
    params.permit(:item_id, :postal_code, :prefecture_id, :city, :block, :building, :tel_number,:order_id).merge(user_id: current_user.id)
  end
end