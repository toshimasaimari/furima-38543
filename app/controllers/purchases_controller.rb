class PurchasesController < ApplicationController
  before_action :authenticate_user!, only: [:index]
  before_action :item_collection, only: [:index, :create]

  def index
    @purchase_address = PurchaseAddress.new
    if current_user == @item.user || @item.purchase.present?
      redirect_to root_path
    end

  end

  def create
    @purchase_address = PurchaseAddress.new(purchase_params)
    if @purchase_address.valid?
      pay_item
      @purchase_address.save
      redirect_to root_path
    else
      render :index
    end
  end


  private

  def purchase_params
    params.require(:purchase_address).permit(:post_code, :prefecture_id, :city, :block, :building, :phone_number).merge(user_id: current_user.id, item_id: params[:item_id], token: params[:token])
  end

  def pay_item
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
      Payjp::Charge.create(
        amount: @item.price,
        card: purchase_params[:token],
        currency: 'jpy'
      )
  end
  def item_collection
    @item = Item.find(params[:item_id])
  end
end
