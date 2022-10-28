class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :edit]
  before_action :set_item, only: [:edit, :show, :update, :destroy]

  def index
    @items = Item.all.order(created_at: :desc)
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

  def show
  end

  def edit
    if @item.purchase.present?
      unless current_user.id == @item.user_id
      redirect_to root_path 
      end
    end
  end

  def update
    @item.update(item_params)
    if @item.save
      redirect_to item_path
    else
      render :edit
    end
  end

  def destroy
    if current_user.id == @item.user_id
    @item.destroy
    redirect_to root_path
    end
  end

  private

  def item_params
    params.require(:item).permit(:image, :product_name, :product_description, :price, :category_id, :condition_id, :shipping_fee_id,
                                 :prefecture_id, :shipping_day_id).merge(user_id: current_user.id)
  end

  def set_item
    @item = Item.find(params[:id])
  end
end
