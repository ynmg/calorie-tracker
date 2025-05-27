class CreatePortions < ActiveRecord::Migration[8.0]
  def change
    create_table :portions do |t|
      t.integer :quantity
      t.references :meal, null: false, foreign_key: true
      t.references :ingredient, null: false, foreign_key: true

      t.timestamps
    end
  end
end
