class CreateResumes < ActiveRecord::Migration
  def change
    create_table :resumes do |t|
      t.text :objective
      t.text :skills
    end
  end
end
