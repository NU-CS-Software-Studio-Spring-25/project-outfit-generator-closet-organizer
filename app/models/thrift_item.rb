class ThriftItem < ApplicationRecord
  belongs_to :clothing
  belongs_to :user

  validates :price, presence: true, numericality: { greater_than: 0 }
end
