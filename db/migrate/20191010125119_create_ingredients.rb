class CreateIngredients < ActiveRecord::Migration[6.0]
  def change
    create_table :ingredients do |t|
      t.string :name, null: false
      t.integer :price
      t.string :unit

      t.timestamps
    end
    change_column_default :ingredients, :unit, "pieces"
    add_index :ingredients, :name, unique: true
  end
end
