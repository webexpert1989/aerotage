class CreateScreeningQuestionnaires < ActiveRecord::Migration
  def change
    create_table :screening_questionnaires do |t|
      t.string :name
      t.integer :passing_score
      t.text :more_email
      t.text :less_email
      t.belongs_to :employer

      t.timestamps
    end
  end
end
