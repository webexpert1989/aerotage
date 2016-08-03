class AddActablePropertyToUsers < ActiveRecord::Migration
  def change
    add_column :users, :actable_id, :integer
    add_column :users, :actable_type, :string
  end
end
