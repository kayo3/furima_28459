class ItemsController < ApplicationController
  before_action :move_to_index, except: :index

  def index
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      render :new
    end
  end

  def move_to_index
    redirect_to action: :index unless user_signed_in?
  end

  private
  def item_params
    params.require(:item).permit(:name, :item_description, :price, :category_id, :status_id, :delivery_fee_id, :prefecture_id, :days_until_shipping_id, :image).merge(user_id: current_user.id)
  end
end
