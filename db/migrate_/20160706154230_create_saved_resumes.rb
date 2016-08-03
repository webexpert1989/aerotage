class CreateSavedResumes < ActiveRecord::Migration
  def change
    create_table :saved_resumes do |t|
      t.belongs_to :resume
      t.belongs_to :employer

      t.timestamps
    end
  end
end
