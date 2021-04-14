class ItemsTag
  include ActiveModel::Model
  attr_accessor :item_name,:explain,:category_id,:condition_id,:delivery_fee_id,:prefecture_id,:delivery_date_id,
  :price,:images,:name,:user_id


  with_options presence: true do
    validates :item_name, length: { in: 1..40 }
    validates :explain, length: { in: 1..1000 }
    validates :category_id
    validates :condition_id
    validates :delivery_fee_id
    validates :prefecture_id
    validates :delivery_date_id
    validates :price, numericality: { only_integer: true, greater_than_or_equal_to: 300, less_than_or_equal_to: 9_999_999 }
    validates :images
  end

  def save
    item=Item.create(item_name: item_name,explain: explain ,category_id: category_id,condition_id: condition_id,delivery_fee_id: delivery_fee_id,
      prefecture_id: prefecture_id,delivery_date_id: delivery_date_id,price: price,user_id: user_id,images: images )
    tag=Tag.where(name: name).first_or_initialize
    tag.save

    ItemTagRelation.create(item_id: item.id,tag_id: tag.id)

  end
  
  
end