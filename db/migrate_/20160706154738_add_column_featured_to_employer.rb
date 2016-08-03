class AddColumnFeaturedToEmployer < ActiveRecord::Migration
  def change
    add_column :employers, :featured, :boolean
  end
end
