class QuestionnaireQuestion < ActiveRecord::Base
  enum answer_type: [ :text, :yes_no, :multiple, :single ]
  serialize :answers, JSON

  belongs_to :questionnaire
  acts_as_list scope: :questionnaire

  validates :content, presence: true
  validates :answer_type, presence: true
  validates :answers, presence: true, unless: :text?

  def answer_type_caption
    self.class.answer_type_caption(answer_type)
  end

  class << self
    def strong_params
      [:content, :required, :answer_type]
    end

    def answer_type_caption(value)
      case value
        when 'text'
          'Text'
        when 'yes_no'
          'Yes / No'
        when 'multiple'
          'List of answers with multiple choice'
        else
          'List of answers with single choice'
      end
    end
  end

end
