class Occupation < ActiveRecord::Base
  has_ancestry

  has_and_belongs_to_many :listings

  default_scope { order('title ASC') }

  validates :title, presence: true

  def self.title_by_id(id)
    Occupation.find(id).title
  end
end
