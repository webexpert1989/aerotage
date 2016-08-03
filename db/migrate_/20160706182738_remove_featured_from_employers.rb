class RemoveFeaturedFromEmployers < ActiveRecord::Migration
  def change
    remove_column :employers, :featured
  end
end
