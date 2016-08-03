class AddActiveAndActiveUntilToListings < ActiveRecord::Migration
  def change
    add_column :listings, :active, :boolean, default: false
    add_column :listings, :active_until, :datetime
  end
end
