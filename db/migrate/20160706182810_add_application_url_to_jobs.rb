class AddApplicationUrlToJobs < ActiveRecord::Migration
  def change
    add_column :jobs, :application_url, :string
  end
end
