class CreatePropertyValuations < ActiveRecord::Migration[7.0]
  def change
    create_table :property_valuations, id: :uuid do |t|
      t.references :settled_property, null: false, foreign_key: true, type: :uuid
      t.datetime :date, null: false
      t.decimal :estimate, null: false

      t.timestamps
    end
  end
end
