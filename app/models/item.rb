class Item < ApplicationRecord
  belongs_to :user

  belongs_to_active_hash :shipping_fee
  belongs_to_active_hash :category
  belongs_to_active_hash :condition
  belongs_to_active_hash :prefecture
  belongs_to_active_hash :shipping_day
  
end
