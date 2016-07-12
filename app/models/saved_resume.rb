class SavedResume < ActiveRecord::Base
  belongs_to :employer
  belongs_to :resume

  validates :employer, presence: true
  validates :resume, presence: true

end
