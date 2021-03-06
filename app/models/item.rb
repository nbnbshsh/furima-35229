class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :condition
  belongs_to :delivery_fee
  belongs_to :prefecture
  belongs_to :delivery_date
  belongs_to :user
  has_one :order
  has_many_attached :images
  has_one :item_order
  has_many :tags, through: :item_tag_relations
  has_many :item_tag_relations,dependent: :destroy

  with_options presence: true do
    validates :item_name, length: { in: 1..40 }
    validates :explain, length: { in: 1..1000 }
    validates :category_id,numericality: { other_than: 1 }
    validates :condition_id,numericality: { other_than: 1 }
    validates :delivery_fee_id,numericality: { other_than: 1 }
    validates :prefecture_id,numericality: { other_than: 1 }
    validates :delivery_date_id,numericality: { other_than: 1 }
    validates :price, numericality: { only_integer: true, greater_than_or_equal_to: 300, less_than_or_equal_to: 9_999_999 }
    validates :images
  end

  validates :category_id, :condition_id, :delivery_fee_id, :prefecture_id, :delivery_date_id, numericality: { other_than: 1 }

  def self.search(search)
    if search != ""
      Item.where('item_name LIKE(?)', "%#{search}%")
    else
      Item.all
    end
  end

end
