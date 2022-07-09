class CreateProperties < ActiveRecord::Migration[7.0]
  def change
    create_table :properties, id: :uuid do |t|
      t.string :pid, null: false, unique: true
      t.string :name, null: false
      t.string :address, null: false
      t.string :suburb, null: false
      t.string :subdivision, null: false
      t.string :country_code, null: false
      t.text :description, null: false
      t.string :image_prefix, null: false
      t.boolean :occupied, null: false
      t.string :category, null: false
      t.string :classification, null: false
      t.references :organization, null: false, foreign_key: true, type: :uuid
      t.references :owner, null: false, foreign_key: {to_table: :sellers}, type: :uuid

      t.timestamps
    end
  end
end
