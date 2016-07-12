class AddResumeDatabaseAccessUntilToEmployers < ActiveRecord::Migration
  def change
    add_column :employers, :resume_database_access_until, :datetime
  end
end
