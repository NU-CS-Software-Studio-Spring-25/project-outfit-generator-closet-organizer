class AddUserToClothings < ActiveRecord::Migration[8.0]
  def change
    add_reference :clothings, :user, null: false, foreign_key: true
  end
end
