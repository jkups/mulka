class CreateOffers < ActiveRecord::Migration[7.0]
  def change
    create_table :offers, id: :uuid do |t|
      t.references :property, null: false, foreign_key: true, type: :uuid
      t.integer :total_units, null: false
      t.integer :minimum_units, null: false
      t.integer :available_units, null: false
      t.decimal :price, null: false, precision: 10, scale: 2
      t.integer :status

      t.timestamps
    end
  end
end
