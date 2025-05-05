class AddArticleToClothings < ActiveRecord::Migration[8.0]
  def change
    add_column :clothings, :article, :string
  end
end
