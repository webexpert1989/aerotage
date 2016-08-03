class CreateSavedJobs < ActiveRecord::Migration
  def change
    create_table :saved_jobs do |t|
      t.belongs_to :job
      t.belongs_to :job_seeker

      t.timestamps
    end
  end
end
