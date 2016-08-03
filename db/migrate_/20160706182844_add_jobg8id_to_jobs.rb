class AddJobg8idToJobs < ActiveRecord::Migration
  def change
    add_column :jobs, :jobg8_id, :string
  end
end
