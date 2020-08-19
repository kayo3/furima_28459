class CreateItems < ActiveRecord::Migration[6.0]
  def change
    create_table :items do |t|
      t.string :name,                    null: false                     
      t.text :item_description,          null: false                     
      t.integer :price,                  null: false                     
      t.integer :category_id,            null: false                     
      t.integer :status_id,              null: false                     
      t.integer :delivery_fee_id,        null: false                     
      t.integer :delivery_from_id,       null: false                     
      t.integer :days_until_shipping_id, null: false                     
      t.references :user,                null: false, foreign_key:  true
      t.timestamps
    end
  end
end
