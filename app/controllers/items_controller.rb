class ItemsController < ApplicationController
  def index
    @items = Item.all
  end

  def new
    @item =Item.new
    if user_signed_in?
      render new_item_path
    else
      redirect_to new_user_session_path
    end
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      render :new
    end
  end

  private

  def item_params
    params.require(:item).permit(:image,:product_name,:product_description,:price,:category_id,:condition_id,:shipping_fee_id,:prefecture_id,:shipping_day_id).merge(user_id: current_user.id)
  end
end
