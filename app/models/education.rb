class Education < ActiveRecord::Base
  include Dateable

  def self.degree_levels
    ['High School', 'Certification', 'Vocational', 'Associate Degree', 'Bachelor’s Degree', 'Master’s Degree', 'Doctorate', 'Professional', 'Other']
  end

  belongs_to :resume

  has_date_field :entrance_date, :graduation_date

  validates :institution_name, :major, :degree_level, presence: true
  validates_inclusion_of :degree_level, in: Education.degree_levels

  def self.strong_params
    [:id, :entrance_date, :graduation_date, :institution_name, :major, :degree_level, :_destroy]
  end

end
