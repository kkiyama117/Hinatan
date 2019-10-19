class CreatePlaces < ActiveRecord::Migration[6.0]
  def change
    create_table :places do |t|
      t.string :name, null: false
      t.string :postal_code, null: false, default: '606-8501'
      t.decimal :latitude, precision: 9, scale: 6, comment: 'to_f to use', null: false, default: 35.026244
      t.decimal :longitude, precision: 9, scale: 6, comment: 'to_f to use', null: false, default: 135.778633
      t.string :address
      t.references :parent, foreign_key: {to_table: :places}

      t.timestamps
    end
  end
end
