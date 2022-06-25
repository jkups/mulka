class CreateSettledProperties < ActiveRecord::Migration[7.0]
  def change
    create_table :settled_properties, id: :uuid do |t|
      t.references :property, null: false, foreign_key: true, type: :uuid
      t.references :property_manager, null: false, foreign_key: true, type: :uuid
      t.references :liaison, null: false, foreign_key: {to_table: :admins}, type: :uuid
      t.integer :status, null: false
      t.decimal :monthly_rent, null: false
      t.datetime :lease_start_on, null: false
      t.datetime :lease_end_on, null: false
      t.string :lease_term, null: false

      t.timestamps
    end
  end
end
