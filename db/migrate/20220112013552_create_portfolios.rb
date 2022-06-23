class CreatePortfolios < ActiveRecord::Migration[7.0]
  def change
    create_table :portfolios, id: :uuid do |t|
      t.string :name, null: false
      t.string :number, null: false, unique: true
      t.boolean :active, null: false
      t.references :buyer, null: false, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
