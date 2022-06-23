class CreateProperties < ActiveRecord::Migration[7.0]
  def change
    create_table :properties, id: :uuid do |t|
      t.string :pid, null: false, unique: true
      t.string :name, null: false
      t.string :address, null: false
      t.string :suburb, null: false
      t.string :city, null: false
      t.string :country, null: false
      t.text :description, null: false
      t.string :image, null: false
      t.boolean :occupied, null: false
      t.string :category, null: false
      t.integer :classification, null: false
      t.references :organization, null: false, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
