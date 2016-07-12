class AddColumnsToQuestionnaireQuestion < ActiveRecord::Migration
  def change
    add_column :questionnaire_questions, :position, :integer
    add_column :questionnaire_questions, :answers, :text
  end
end
