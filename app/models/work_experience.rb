class WorkExperience < ActiveRecord::Base
  include Markdownable
  include Dateable

  belongs_to :resume

  has_markdown_field :description
  has_date_field :start_date, :end_date

  validates :company_name, :job_title, presence: true

  class << self
    def strong_params
      [:id, :company_name, :job_title, :description_raw, :start_date, :end_date, :_destroy]
    end
  end
end
