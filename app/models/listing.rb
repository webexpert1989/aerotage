class Listing < ActiveRecord::Base
  actable

  belongs_to :location
  has_and_belongs_to_many :communities
  has_and_belongs_to_many :occupations
  has_and_belongs_to_many :employment_types
  has_many :flags, dependent: :destroy

  validates :title, presence: true, length: { maximum: 140 }
  validates :location, presence: true
  validates :communities, presence: true
  validates :salary, numericality: true, allow_blank: true

  def self.salary_types
    ['per hour', 'per week', 'per month', 'per year']
  end

  def display_name
    "'#{title}' #{specific.to_s}"
  end

  def job?
    specific.class == Job
  end

  def resume?
    specific.class == Resume
  end

  def user
    job? ? specific.employer : specific.job_seeker
  end

  def priority?
    is_priority
  end

  def featured?
    is_featured
  end

  def never_activated?
    !active_until.present?
  end

  def expired?
    !active_until.present? || active_until < Time.now
  end

  def activate
    unless expired?
      update_attribute(:active, true)
      return true
    end
    false
  end

  def deactivate
    update_attribute(:active, false)
  end

  class << self
    def strong_params
      [:title, :location_id, :salary, :salary_type, :views, community_ids: [], employment_type_ids: [], occupation_ids: []]
    end
  end

end
