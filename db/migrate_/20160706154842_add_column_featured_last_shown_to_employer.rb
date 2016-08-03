class AddColumnFeaturedLastShownToEmployer < ActiveRecord::Migration
  def change
    add_column :employers, :featured_last_shown, :datetime
  end
end
