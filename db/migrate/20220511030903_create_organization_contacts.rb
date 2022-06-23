class CreateOrganizationContacts < ActiveRecord::Migration[7.0]
  def change
    create_table :organization_contacts, id: :uuid do |t|
      t.string :name, null: false
      t.string :email, null: false
      t.string :mobile_number, null: false
      t.references :organization, null: false, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
