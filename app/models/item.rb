class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category,:condition,:delivery,:prefecture,:delivery
  #belongs_to :user
  #has_one :purchase_record
  has_one_attached :image
  
  with_options presence: true do
   validates :item_name
   validates :explain
   validates :category_id
   validates :condition_id
   validates :delivery_fee_id
   validates :prefecture_id
   validates :delivery_date_id
   validates :price
   validates :user
   validates :image
  end

  validates :category_id,:condition_id,:delivery_fee_id,:prefecture_id,:delivery_date_id, numericality: { other_than: 1 } 

end
