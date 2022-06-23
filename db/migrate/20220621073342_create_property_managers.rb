class CreatePropertyManagers < ActiveRecord::Migration[7.0]
  def change
    create_table :property_managers, id: :uuid do |t|
      t.string :full_name, null: false
      t.string :mobile, null: false
      t.string :email, null: false
      t.string :company_name, null: false

      t.timestamps
    end
  end
end
