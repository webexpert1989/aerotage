class CreateScreeningQuestionnaireQuestions < ActiveRecord::Migration
  def change
    create_table :screening_questionnaire_questions do |t|
      t.text :content
      t.boolean :required
      t.integer :answer_type, default: 0

      t.belongs_to :screening_questionnaire

      t.timestamps
    end

    add_index :screening_questionnaire_questions, :screening_questionnaire_id, name: 'index_screening_questionnaire_questions'
  end
end
