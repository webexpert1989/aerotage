class AddFeaturedUntilToEmployers < ActiveRecord::Migration
  def change
    add_column :employers, :featured_until, :datetime
  end
end
