class AddSalaryToListings < ActiveRecord::Migration
  def change
    add_column :listings, :salary, :float
    add_column :listings, :salary_type, :string, limit: 10
  end
end
