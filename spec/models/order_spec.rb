require 'rails_helper'

RSpec.describe Order, type: :model do
  # has_one :address
  belongs_to :item
  belongs_to :user
end
