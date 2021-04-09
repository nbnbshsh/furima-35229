FactoryBot.define do
  factory :order_address do
    token                { 'tok_asdfghjkl1234567890' }
    postal_code          { '123-4567' }
    prefecture_id        { 2 }
    municipality         { '日立市山城町' }
    address              { '2-2' }
    building_name        { 'スカイハイツ' }
    telephone_number     { '08012345678' }
    user_id              { '1' }
    item_id              { '1' }
  end
end
