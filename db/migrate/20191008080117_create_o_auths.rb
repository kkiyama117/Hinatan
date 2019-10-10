class CreateOAuths < ActiveRecord::Migration[6.0]
  def change
    create_table :o_auths do |t|
      t.references :user, foreign_key: true, null: false
      t.string :provider, null: false
      t.string :uid, null: false
      t.string :token, null: false

      t.timestamps
    end
    add_index :o_auths, %i[provider uid], unique: true
  end
end
