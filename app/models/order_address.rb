class OrderAddress
  include ActiveModel::Model
  attr_accessor :token, :postal_code, :prefecture_id, :municipality, :address, :building_name, :telephone_number, :item_id,
                :user_id

  with_options presence: true do
    validates :postal_code, format: { with: /\A\d{3}-\d{4}\z/ }
    validates :prefecture_id, numericality: { other_than: 1 }
    validates :municipality
    validates :address
    validates :telephone_number, format: { with: /\A\d{,11}\z/ }
    validates :token
    validates :user_id
    validates :item_id
  end

  def save
    order=Order.create(user_id: user_id, item_id: item_id)
    Address.create(postal_code: postal_code, prefecture_id: prefecture_id, municipality: municipality, address: address,building_name: building_name, telephone_number: telephone_number,order_id: order.id)
  end
end
