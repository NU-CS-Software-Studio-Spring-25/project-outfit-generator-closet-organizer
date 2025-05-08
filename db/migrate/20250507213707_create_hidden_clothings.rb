class CreateHiddenClothings < ActiveRecord::Migration[8.0]
  def change
    create_table :hidden_clothings do |t|
      t.references :user, null: false, foreign_key: true
      t.references :clothing, null: false, foreign_key: true

      t.timestamps
    end
  end
end
