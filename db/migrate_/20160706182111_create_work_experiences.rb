class CreateWorkExperiences < ActiveRecord::Migration
  def change
    create_table :work_experiences do |t|
      t.date :start_date
      t.date :end_date
      t.string :job_title
      t.string :company_name
      t.text :description
      t.text :description_raw

      t.belongs_to :resume, index: true

      t.timestamps
    end
  end
end
