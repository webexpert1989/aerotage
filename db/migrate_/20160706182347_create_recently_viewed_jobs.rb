class CreateRecentlyViewedJobs < ActiveRecord::Migration
  def change
    create_table :recently_viewed_jobs do |t|
      t.belongs_to :job_seeker, index: true
      t.belongs_to :job, index: true

      t.timestamps
    end

    add_index :recently_viewed_jobs, [:job_id, :job_seeker_id], unique: true
  end
end
