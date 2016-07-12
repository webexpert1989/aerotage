class SavedJob < ActiveRecord::Base
  belongs_to :job_seeker
  belongs_to :job

  validates :job_seeker, presence: true
  validates :job, presence: true

end
