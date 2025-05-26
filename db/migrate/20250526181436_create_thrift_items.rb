class CreateThriftItems < ActiveRecord::Migration[8.0]
  def change
    create_table :thrift_items do |t|
      t.references :clothing, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.decimal :price

      t.timestamps
    end
  end
end
