class Resume < ActiveRecord::Base
  include Fileable
  include Markdownable
  include RadiusSearchable

  extend FriendlyId
  friendly_id :slug_candidates, use: :slugged
  def slug_candidates
    [:resume_title, [:resume_title, :city_state_code], [:resume_title, :city_state_code, :job_seeker_name]]
  end
  def should_generate_new_friendly_id?
    title_changed? || super
  end

  acts_as :listing

  belongs_to :job_seeker
  has_many :applications, dependent: :destroy

  has_many :saved_resumes, dependent: :destroy

  has_many :educations, dependent: :destroy
  accepts_nested_attributes_for :educations, :reject_if => :all_blank, :allow_destroy => true

  has_many :work_experiences, dependent: :destroy
  accepts_nested_attributes_for :work_experiences, :reject_if => :all_blank, :allow_destroy => true

  has_markdown_field :objective
  has_markdown_field :skills
  has_one_file :resume, :documentable, 'Document'

  default_scope -> { order('listings.is_priority DESC, listings.created_at DESC') }
  scope :eager_loaded, -> { eager_load(job_seeker: :user, listing: :location) }

  validates :job_seeker, presence: true
  validates :total_experience, numericality: { greater_than_or_equal_to: 0 }, allow_blank: true

  ransacker :listing_created_at do
    Arel.sql('DATE(listings.created_at)')
  end
  ransacker :listing_activated_at do
    Arel.sql('DATE(listings.first_activated_at)')
  end
  ransacker :smart_location

  def to_s
    'resume'
  end

  def resume?
    true
  end

  def resume_title
    title
  end

  def city_state_code
    location.city + ', ' + location.state_code
  end

  def job_seeker_name
    job_seeker.display_name
  end

  def owner
    job_seeker
  end

  class << self
    def strong_params
      [:objective_raw, :skills_raw, :hidden, :total_experience,
       resume_attributes: Document.strong_params,
       educations_attributes: Education.strong_params,
       work_experiences_attributes: WorkExperience.strong_params
      ] + Listing.strong_params
    end
  end

end
