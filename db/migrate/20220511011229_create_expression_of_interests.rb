class CreateExpressionOfInterests < ActiveRecord::Migration[7.0]
  def change
    create_table :expression_of_interests, id: :uuid do |t|
      t.references :offer, null: false, foreign_key: true, type: :uuid
      t.references :buyer, null: false, foreign_key: true, type: :uuid
      t.integer :units, null: false

      t.timestamps
    end
  end
end
