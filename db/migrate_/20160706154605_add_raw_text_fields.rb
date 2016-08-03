class AddRawTextFields < ActiveRecord::Migration
  def change
    add_column :jobs, :job_description_raw, :text
    add_column :jobs, :job_requirements_raw, :text
    add_column :resumes, :objective_raw, :text
    add_column :resumes, :skills_raw, :text
    add_column :employers, :company_description_raw, :text
  end
end
