class ChangeUserIdNullOnClothings < ActiveRecord::Migration[8.0]
  def change
    change_column_null :clothings, :user_id, true
  end
end
