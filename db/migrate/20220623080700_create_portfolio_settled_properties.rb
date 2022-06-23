class CreatePortfolioSettledProperties < ActiveRecord::Migration[7.0]
  def change
    create_table :portfolio_settled_properties, id: :uuid do |t|
      t.references :portfolio, null: false, foreign_key: true, type: :uuid
      t.references :settled_property, null: false, foreign_key: true, type: :uuid
      t.integer :units

      t.timestamps
    end
  end
end
