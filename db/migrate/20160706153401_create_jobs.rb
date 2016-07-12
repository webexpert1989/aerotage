class CreateJobs < ActiveRecord::Migration
  def change
    create_table :jobs do |t|
      t.text :job_description
      t.text :job_requirements
    end
  end
end
