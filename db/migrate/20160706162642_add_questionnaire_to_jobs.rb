class AddQuestionnaireToJobs < ActiveRecord::Migration
  def change
    change_table :jobs do |t|
      t.belongs_to :questionnaire
    end
  end
end
