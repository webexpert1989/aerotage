class Employer < ActiveRecord::Base
  include Fileable
  include Markdownable

  extend FriendlyId
  friendly_id :slug_candidates, use: :slugged
  def slug_candidates
    [:company_name, [:company_name, :city], [:company_name, :city, :state_code]]
  end
  def should_generate_new_friendly_id?
    company_name_changed? || super
  end

  acts_as :user

  has_many :jobs, dependent: :destroy
  has_many :saved_resumes, source: :resume, through: :saved_resumes_link
  has_many :saved_resumes_link, class_name: 'SavedResume', dependent: :destroy
  has_many :questionnaires, dependent: :destroy
  has_many :blog_post_comments, as: :commenter, dependent: :destroy
  has_many :applications, -> { reorder('applications.created_at DESC') }, through: :jobs
  has_one_file :logo, :imageable, 'Image'
  has_one_file :video, :videoable, 'Video'

  has_markdown_field :company_description

  default_scope -> { order('users.created_at DESC') }
  scope :active, -> { where(activated: true) }
  scope :with_logo, -> { eager_load(:logo).where('images.imageable_id IS NOT NULL') }
  scope :featured, -> { with_logo.where('featured_until > NOW()').reorder('featured_last_shown ASC NULLS FIRST') }

  validates :company_name, presence: false

  ransacker :smart_location

  def to_s
    'employer'
  end

  def employer?
    true
  end

  def display_name
    company_name
  end

  def has_saved_resume?(resume)
    saved_resumes.include?(resume)
  end

  def featured?
    featured_until.present? and featured_until > Time.now
  end

  def has_resume_database_access?
    resume_database_access_until.present? and resume_database_access_until > Time.now
  end

  def city
    location.city if location
  end

  def state_code
    location.state_code if location
  end

  def can_view_resume?(resume)
    applications.where(resume: resume).exists?
  end

  def application_alerts_count
    applications.includes(:messages).where("status = 0 OR (is_read = false AND sender = 'job seeker')").size
  end

  class << self
    def strong_params
      [:company_name, :contact_name, :phone_number, :web_site, :company_description_raw,
       logo_attributes: Image.strong_params, video_attributes: Video.strong_params] + User.strong_params
    end
  end

end
