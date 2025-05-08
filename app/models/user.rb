class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :clothings, dependent: :destroy
  has_many :outfits
  has_many :hidden_clothings, dependent: :destroy
  has_many :hidden_clothing_items, through: :hidden_clothings, source: :clothing
end
