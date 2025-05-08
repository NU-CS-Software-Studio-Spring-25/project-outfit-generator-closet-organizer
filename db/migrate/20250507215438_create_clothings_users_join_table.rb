class CreateClothingsUsersJoinTable < ActiveRecord::Migration[8.0]
  def change
    create_join_table :users, :clothings do |t|
      t.index [:user_id, :clothing_id], unique: true
    end
  end
end
