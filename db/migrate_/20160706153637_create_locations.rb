class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.string :zip_code, limit: 7
      t.string :city, limit: 100
      t.string :state, limit: 50
      t.string :state_code, limit: 2
      t.string :country, limit: 50
      t.string :country_code, limit: 2
      t.float :latitude
      t.float :longitude
    end

    add_index :locations, [:zip_code, :city], unique: true
  end
end
