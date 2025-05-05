class CreateClothings < ActiveRecord::Migration[8.0]
  def change
    create_table :clothings do |t|
      t.string :name
      t.string :brand
      t.string :category
      t.string :article

      t.timestamps
    end
  end
end
