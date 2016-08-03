class ChangeUsersListingsRelation < ActiveRecord::Migration
  def change
    add_column :jobs, :employer_id, :integer
    add_column :resumes, :job_seeker_id, :integer

    remove_column :listings, :user_id, :integer
  end
end
