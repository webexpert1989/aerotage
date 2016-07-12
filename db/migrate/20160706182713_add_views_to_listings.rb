class AddViewsToListings < ActiveRecord::Migration
  def change
    add_column :listings, :views, :integer, null: false, default: 0
  end
end
