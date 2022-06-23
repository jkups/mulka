class CreateExternalReferences < ActiveRecord::Migration[7.0]
  def change
    create_table :external_references, id: :uuid do |t|
      t.string :referenceable_source
      t.string :referenceable_id

      t.timestamps
    end
  end
end
