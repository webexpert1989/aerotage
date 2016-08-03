class CreateJobSeekers < ActiveRecord::Migration
  def change
    create_table :job_seekers do |t|
      t.string :first_name, limit: 50
      t.string :last_name, limit: 50
      t.string :phone_number, limit: 30

      t.string :profile_picture_uid
    end
  end
end
