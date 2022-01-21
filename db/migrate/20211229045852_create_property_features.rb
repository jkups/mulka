class CreatePropertyFeatures < ActiveRecord::Migration[7.0]
  def change
    create_table :property_features, id: :uuid do |t|
      t.references :property, null: false, foreign_key: true, type: :uuid
      t.integer :bed_count, null: false
      t.integer :bath_count, null: false
      t.integer :carpark, null: false
      t.string :prop_type, null: false
      t.integer :plot_size, null: false

      t.timestamps
    end
  end
end
