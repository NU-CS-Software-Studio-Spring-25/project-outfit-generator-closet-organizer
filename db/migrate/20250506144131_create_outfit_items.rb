class CreateOutfitItems < ActiveRecord::Migration[8.0]
  def change
    create_table :outfit_items do |t|
      t.references :outfit, null: false, foreign_key: true
      t.references :clothing, null: false, foreign_key: true

      t.timestamps
    end
  end
end
