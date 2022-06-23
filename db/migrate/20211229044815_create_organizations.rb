class CreateOrganizations < ActiveRecord::Migration[7.0]
  def change
    create_table :organizations, id: :uuid do |t|
      t.string :name, null: false
      t.string :address, null: false
      t.string :suburb, null: false
      t.string :city, null: false
      t.string :country, null: false
      t.string :registration_number, null: false

      t.timestamps
    end
  end
end
