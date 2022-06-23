class CreateTranzactions < ActiveRecord::Migration[7.0]
  def change
    create_table :tranzactions, id: :uuid do |t|
      t.integer :units, null: false
      t.decimal :amount, null: false, precision: 10, scale: 2
      t.decimal :fee, null: false, precision: 10, scale: 2
      t.references :offer, null: false, foreign_key: true, type: :uuid
      t.references :portfolio, null: false, foreign_key: true, type: :uuid
      t.references :external_reference, null: false, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
