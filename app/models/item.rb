class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :condition
  belongs_to :delivery_fee
  belongs_to :prefecture
  belongs_to :delivery_date
  belongs_to :user
  # has_one :purchase_record
  has_one_attached :image

  with_options presence: true do
    validates :item_name, length: { in: 1..40 }
    validates :explain, length: { in: 1..1000 }
    validates :category_id
    validates :condition_id
    validates :delivery_fee_id
    validates :prefecture_id
    validates :delivery_date_id
    validates :price, numericality: { only_integer: true, greater_than_or_equal_to: 300, less_than_or_equal_to: 9_999_999 }
    validates :image
  end

  validates :category_id, :condition_id, :delivery_fee_id, :prefecture_id, :delivery_date_id, numericality: { other_than: 1 }
end
