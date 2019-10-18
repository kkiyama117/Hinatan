class CreatePlaces < ActiveRecord::Migration[6.0]
  def change
    create_table :places do |t|
      t.string :name
      t.decimal :latitude, precision: 9, scale: 6, comment: 'to_f to use'
      t.decimal :longitude, precision: 9, scale: 6, comment: 'to_f to use'
      t.string :address

      t.timestamps
    end
  end
end
