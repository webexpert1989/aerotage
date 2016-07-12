class EmploymentType < ActiveRecord::Base

  has_and_belongs_to_many :listings

  validates :title, presence: true

  def self.title_by_id(id)
    EmploymentType.find(id).title
  end

end
