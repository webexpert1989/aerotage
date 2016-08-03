class AddFieldsToResume < ActiveRecord::Migration
  def change
    add_column :resumes, :hidden, :boolean, default: false
    add_column :resumes, :total_experience, :integer
  end
end
