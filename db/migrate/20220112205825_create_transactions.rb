class CreateTransactions < ActiveRecord::Migration[7.0]
  def change
    create_table :transactions, id: :uuid do |t|
      t.integer :units, null: false
      t.integer :value, null: false
      t.integer :fee, null: false
      t.string :trxn_number, null: false
      t.integer :status, null: false, default: 0
      t.string :pay_id
      t.references :property, null: false, foreign_key: true, type: :uuid
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
