class Message < ActiveRecord::Base
  belongs_to :application

  validates :content, :sender, :application, presence: true

  default_scope -> { order('created_at ASC') }

  def to_employer?
    sender != 'employer'
  end

  def to_job_seeker?
    sender != 'job seeker'
  end

end
