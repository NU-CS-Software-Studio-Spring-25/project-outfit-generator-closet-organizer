class AddDescriptionToOutfits < ActiveRecord::Migration[8.0]
  def change
    add_column :outfits, :description, :string
  end
end
