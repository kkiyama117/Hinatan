class CreateRoleAbilities < ActiveRecord::Migration[6.0]
  def change
    create_table :role_abilities do |t|
      t.references :role, null: false, foreign_key: true
      t.references :ability, null: false, foreign_key: true

      t.timestamps
    end
  end
end
