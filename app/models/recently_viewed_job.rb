class RecentlyViewedJob < ActiveRecord::Base
  belongs_to :job_seeker
  belongs_to :job

  validates :job_seeker, presence: true
  validates :job, presence: true

  default_scope -> { order('recently_viewed_jobs.updated_at DESC') }
end
