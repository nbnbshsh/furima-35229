class Address < ApplicationRecord
  belongs_to :donation
  belongs_to :prefecture

  
end
