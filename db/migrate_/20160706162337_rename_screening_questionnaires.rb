class RenameScreeningQuestionnaires < ActiveRecord::Migration
  def change
    rename_table :screening_questionnaires, :questionnaires
    rename_table :screening_questionnaire_questions, :questionnaire_questions
  end
end
