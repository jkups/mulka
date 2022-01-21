class CreateAccounts < ActiveRecord::Migration[7.0]
  def change
    create_table :accounts, id: :uuid do |t|
      t.string :name, null: false
      t.string :number, null: false
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
