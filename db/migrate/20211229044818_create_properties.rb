class CreateProperties < ActiveRecord::Migration[7.0]
  def change
    create_table :properties, id: :uuid do |t|
      t.string :pid, null: false, unique: true
      t.string :name, null: false
      t.integer :status, null: false
      t.text :address, null: false
      t.integer :listing_price, null: false
      t.integer :total_units, null: false
      t.integer :available_units, null: false
      t.integer :minimum_units, null: false
      t.text :description, null: false
      t.string :image, null: false

      t.timestamps
    end
  end
end
