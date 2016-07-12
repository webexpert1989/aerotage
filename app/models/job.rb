class Job < ActiveRecord::Base
  include Markdownable
  include RadiusSearchable

  extend FriendlyId
  friendly_id :slug_candidates, use: :slugged
  def slug_candidates
    [:job_title, [:job_title, :city_state_code], [:job_title, :city_state_code, :company_name]]
  end
  def should_generate_new_friendly_id?
    title_changed? || super
  end

  acts_as :listing

  belongs_to :employer
  belongs_to :questionnaire
  has_many :applications, dependent: :destroy

  has_many :saved_jobs, dependent: :destroy
  has_many :recently_viewed_jobs, dependent: :destroy

  has_markdown_field :job_description
  has_markdown_field :job_requirements

  default_scope -> { order('listings.created_at DESC') }
  scope :active, -> { where(active: true) }
  scope :eager_loaded, -> { eager_load(employer: :user, listing: :location) }
  scope :in_community, ->(community_ids) { ransack(listing_communities_id_in: [*community_ids]).result }
  scope :all_except, ->(job) { where.not(id: job) }

  validates :employer, presence: true

  ransacker :listing_created_at do
    Arel.sql('DATE(listings.created_at)')
  end
  ransacker :listing_activated_at do
    Arel.sql('DATE(listings.first_activated_at)')
  end
  ransacker :smart_location

  def to_s
    'job'
  end

  def job?
    true
  end

  def job_title
    title
  end

  def city_state_code
    location.city + ', ' + location.state_code
  end

  def company_name
    employer.company_name
  end

  def owner
    employer
  end

  class << self
    def strong_params
      [:job_description_raw, :job_requirements_raw, :questionnaire_id] + Listing.strong_params
    end

    def import_collection(file)
      doc = Nokogiri::XML(file)
      doc.xpath('//Jobs/Job').each do |xml_job|

        job_hash = {}
        xml_job.xpath('*').each do |xml_field|
          job_hash[xml_field.name] = xml_field.content.squish
        end

        case xml_job.attr('Action')
          when 'Delete'
            Job.find_by_jobg8_id(job_hash['SenderReference']).destroy
          when 'Post'
            import_record(job_hash)
          when 'Amend'
            amend_record(job_hash)
          else
        end

      end
    end

    private

    def import_record(record)

      return unless record['JobType'] == 'APPLICATION'
      return unless record['Country'] == 'United States'
      return if record['PostalCode'].blank?

      location = Location.find_by(zip_code: record['PostalCode'], city: record['Area'])
      location = Location.find_by_zip_code(record['PostalCode']) if location.nil?

      return if location.nil?

      company_name = record['AdvertiserName']

      employer = Employer.find_or_create_by!(company_name: company_name) do |e|
        e.email = 'should_be_changed@example.com'
        e.password = SecureRandom.hex
        e.location = location
        e.company_name = company_name
        e.contact_name = record['ContactName']
        e.logo = Image.create(image_url: record['LogoURL'])
      end

      employer.update(email: "jobg8.employer#{employer.id}@aerotagejobs.com") if employer.email == 'should_be_changed@example.com'

      Job.create!(employer: employer,
                  title: record['Position'],
                  location: location,
                  communities: get_imported_communities(record),
                  salary: '',
                  employment_types: get_imported_employment_types(record),
                  job_description: record['Description'],
                  salary_type: get_imported_salary_type(record['SalaryPeriod']),
                  application_url: record['ApplicationURL'],
                  jobg8_id: record['SenderReference'],
      )

    end

    def amend_record(record)

      job = Job.find_by_jobg8_id(record['SenderReference'])

      job.update!(title: record['Position'],
                  communities: get_imported_communities(record),
                  salary: '',
                  employment_types: get_imported_employment_types(record),
                  job_description: record['Description'],
                  salary_type: get_imported_salary_type(record['SalaryPeriod']),
                  application_url: record['ApplicationURL'],
      )

    end

    def get_imported_salary_type(v)
      mapping = {'Hourly' => 'per hour', 'Daily' => 'per day', 'Weekly' => 'per week', 'Monthly' => 'per month', 'Annual' => 'per year'}
      mapping[v]
    end

    def get_imported_communities(record)
      v = []
      %w(Classification AdditionalClassification1 AdditionalClassification2 AdditionalClassification3 AdditionalClassification4).each do |t|
        v << get_imported_community(record[t]) unless record[t].empty?
      end
      v.reject(&:blank?)
    end

    def get_imported_community(v)
      mapping = {'I.T. & Communications' => 'Informational Technology'}
      Community.find_by_title(mapping[v] || v)
    end

    def get_imported_employment_types(record)
      employment_types = []
      employment_types << get_imported_employment_type(record['EmploymentType'])
      employment_types << get_imported_employment_type(record['WorkHours'])
      employment_types.reject(&:blank?)
    end

    def get_imported_employment_type(v)
      mapping = {'Full Time' => 'Permanent', 'Contract' => 'Contract', 'Temporary' => 'Part Time'}
      EmploymentType.find_by_title(mapping[v])
    end

  end

end
