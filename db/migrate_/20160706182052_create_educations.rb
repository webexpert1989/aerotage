class CreateEducations < ActiveRecord::Migration
  def change
    create_table :educations do |t|
      t.date :entrance_date
      t.date :graduation_date
      t.string :institution_name
      t.string :major
      t.string :degree_level

      t.belongs_to :resume, index: true

      t.timestamps
    end
  end
end
