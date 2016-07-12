class Application < ActiveRecord::Base
  include Markdownable
  serialize :questionnaire, JSON

  enum status: [ :not_reviewed, :reviewed, :phone_screened, :interviewed, :offer_made, :rejected, :hired ]

  belongs_to :resume
  belongs_to :job
  delegate :job_seeker, :to => :resume, :allow_nil => true
  delegate :employer, :to => :job, :allow_nil => true
  has_many :messages, dependent: :destroy

  has_markdown_field :cover_letter

  default_scope -> { eager_load(:job, :resume) }

  validates :job, :resume, presence: true

  def new_messages_count(sender)
    messages.where(is_read: false, sender: sender).size
  end

  def can_reply?
    messages.present? && !rejected? && !hired?
  end

  def make_messages_read(receiver)
    messages.where.not(sender: receiver).update_all(is_read: true)
  end

  class << self
    def strong_params
      [:resume_id, :cover_letter_raw]
    end
  end

end
