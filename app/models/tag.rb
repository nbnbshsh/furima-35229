class Tag < ApplicationRecord
  has_many :items, through: :item_tag_relations
  has_many :item_tag_relations

  validates :name,uniqueness: true

  def self.search(search)
    if search != ""
      Tag.where('text LIKE(?)', "%#{search}%")
    else
      Tag.all
    end
  end
end
