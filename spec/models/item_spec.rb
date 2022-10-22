require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    @item = FactoryBot.build(:item)
  end
  
  describe "商品出品機能" do
    context '商品出品がうまくいくとき' do
      it "image,item_name,description,category_id,status_id,prefecture_id,delivery_fee_payment_id,delivery_prepare_id,priceの値が存在すれば登録できること" do
        expect(@item).to be_valid
      end
      it "priceが300(半角数字)であれば登録できる" do
        @item.price = '300'
        expect(@item).to be_valid
      end
      it "priceが9999999(半角数字)であれば登録できる" do
        @item.price = '9999999'
        expect(@item).to be_valid
      end
    end

    context '商品出品がうまくいかないとき' do
      it "imageが空では登録できない" do
        @item.image = nil
        @item.valid?
        expect(@item.errors.full_messages).to include "Image can't be blank"
      end
      it "product_nameが空では登録できない" do
        @item.product_name = nil
        @item.valid?
        expect(@item.errors.full_messages).to include "Product name can't be blank"
      end
      it "priceが空では登録できない" do
        @item.price = nil
        @item.valid?
        expect(@item.errors.full_messages).to include "Price can't be blank"
      end
      it "priceが300未満では登録できない" do
        @item.price = '299'
        @item.valid?
        expect(@item.errors.full_messages).to include "Price must be greater than or equal to 300"
      end
      it "priceが9999999より高いと登録できない" do
        @item.price = '10000000'
        @item.valid?
        expect(@item.errors.full_messages).to include "Price must be less than or equal to 9999999"
      end
      it "priceが全角では登録できない" do
        @item.price = '３００'
        @item.valid?
        expect(@item.errors.full_messages).to include "Price is not a number"
      end
      it "category_idが1では登録できない" do
        @item.category_id = '1'
        @item.valid?
        expect(@item.errors.full_messages).to include "Category can't be blank"
      end
      it "condition_idが1では登録できない" do
        @item.condition_id = '1'
        @item.valid?
        expect(@item.errors.full_messages).to include "Condition can't be blank"
      end
      it "shipping_fee_idが1では登録できない" do
        @item.shipping_fee_id = '1'
        @item.valid?
        expect(@item.errors.full_messages).to include "Shipping fee can't be blank"
      end
      it "prefecture_idが1では登録できない" do
        @item.prefecture_id = '1'
        @item.valid?
        expect(@item.errors.full_messages).to include "Prefecture can't be blank"
      end
      it "shipping_day_idが1では登録できない" do
        @item.shipping_day_id = '1'
        @item.valid?
        expect(@item.errors.full_messages).to include "Shipping day can't be blank"
      end
      it "ユーザーが紐付いていなければ投稿できない" do
        @item.user = nil
        @item.valid?
        expect(@item.errors.full_messages).to include "User must exist"
      end
    end
  end
end