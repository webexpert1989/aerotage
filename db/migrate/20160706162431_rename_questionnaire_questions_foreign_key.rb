class RenameQuestionnaireQuestionsForeignKey < ActiveRecord::Migration
  def change
    rename_column :questionnaire_questions, :screening_questionnaire_id, :questionnaire_id
  end
end
