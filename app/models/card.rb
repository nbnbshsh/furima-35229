class Card < ApplicationRecord
  belongs_to :user
  validates :customer_token,:card_token, presence: true
end
