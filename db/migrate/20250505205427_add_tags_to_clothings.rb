class AddTagsToClothings < ActiveRecord::Migration[8.0]
  def change
    add_column :clothings, :tags, :string
  end
end
