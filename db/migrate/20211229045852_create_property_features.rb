class CreatePropertyFeatures < ActiveRecord::Migration[7.0]
  def change
    create_table :property_features, id: :uuid do |t|
      t.references :property, null: false, foreign_key: true, type: :uuid
      t.integer :bed, null: false
      t.integer :bath, null: false
      t.integer :parking, null: false
      t.integer :floor_size, null: false
      t.integer :plot_size, null: false

      t.timestamps
    end
  end
end
