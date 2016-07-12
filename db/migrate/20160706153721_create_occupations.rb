class CreateOccupations < ActiveRecord::Migration
  def change
    create_table :occupations do |t|
      t.string :title, limit: 100
      t.string :ancestry
    end

    add_index :occupations, :ancestry

    create_table :listings_occupations, id: false do |t|
      t.belongs_to :occupation
      t.belongs_to :listing
    end
  end
end
