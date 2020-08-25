class OrdersController < ApplicationController
  def index
    @item = Item.find(params[:item_id])
    unless user_signed_in?
      redirect_to new_user_session_path
    end
  end

  def create
  end
end