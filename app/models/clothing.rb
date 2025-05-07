class Clothing < ApplicationRecord
    has_one_attached :image
    belongs_to :user, optional: true
    has_many :outfit_items
    has_many :outfits, through: :outfit_items
end
