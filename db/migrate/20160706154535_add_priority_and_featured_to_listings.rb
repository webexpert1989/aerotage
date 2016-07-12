class AddPriorityAndFeaturedToListings < ActiveRecord::Migration
  def change
    add_column :listings, :is_priority, :boolean, default: false
    add_column :listings, :is_featured, :boolean, default: false
    add_column :listings, :featured_last_shown, :datetime
  end
end
