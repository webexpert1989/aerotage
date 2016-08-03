class CreateListings < ActiveRecord::Migration
  def change
    create_table :listings do |t|
      t.string :title
      t.integer :user_id

      t.integer :location_id

      t.text :keywords

      t.actable
      t.timestamps
    end
  end
end
