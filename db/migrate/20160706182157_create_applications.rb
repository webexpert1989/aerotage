class CreateApplications < ActiveRecord::Migration
  def change
    create_table :applications do |t|
      t.belongs_to :resume, index: true
      t.belongs_to :job, index: true
      t.text :cover_letter
      t.text :questionnaire
      t.integer :status, default: 0

      t.timestamps
    end
  end
end
