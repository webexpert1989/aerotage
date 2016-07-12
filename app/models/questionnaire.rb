class Questionnaire < ActiveRecord::Base
  enum passing_score: [ :not_acceptable, :acceptable, :good, :very_good, :excellent ]

  belongs_to :employer
  has_many :questions, -> { order('position ASC') }, class_name: 'QuestionnaireQuestion', dependent: :destroy

  validates :name, :passing_score, presence: true

  class << self

    def strong_params
      [:name, :passing_score, :more_email, :less_email]
    end

  end

end
