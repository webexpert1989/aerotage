class JobSeeker < ActiveRecord::Base
  include Fileable

  acts_as :user

  has_many :resumes, dependent: :destroy
  has_many :blog_post_comments, as: :commenter, dependent: :destroy
  has_many :applications, -> { reorder('applications.created_at DESC') }, through: :resumes

  has_many :saved_jobs, source: :job, through: :saved_jobs_link
  has_many :saved_jobs_link, class_name: 'SavedJob', dependent: :destroy

  has_many :recently_viewed_jobs, -> { reorder('recently_viewed_jobs.updated_at DESC') }, source: :job, through: :recently_viewed_job_links
  has_many :recently_viewed_job_links, class_name: 'RecentlyViewedJob', dependent: :destroy

  has_one_file :profile_picture, :imageable, 'Image'

  default_scope -> { order('users.created_at DESC') }

  validates :first_name, :last_name, presence: false

  def to_s
    'job seeker'
  end

  def job_seeker?
    true
  end

  def display_name
    #first_name + ' ' + last_name
  end

  def has_saved_job?(job)
    saved_jobs.include?(job)
  end

  def add_recently_viewed_job(job)
    if recently_viewed_jobs.exists?(job)
      recently_viewed_job_links.find_by_job_id(job.id).touch
    else
      recently_viewed_jobs << job
      if recently_viewed_job_links.size > 8
        last = recently_viewed_job_links.limit(8).last
        recently_viewed_job_links.where('recently_viewed_jobs.updated_at < ?', last.updated_at).destroy_all
      end
    end
  end

  def application_alerts_count
    applications.includes(:messages).where("is_read = false AND sender = 'employer'").size
  end

  class << self
    def strong_params
      [:first_name, :last_name, :phone_number, profile_picture_attributes: Image.strong_params] + User.strong_params
    end
  end

end
