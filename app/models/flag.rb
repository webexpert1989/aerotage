class Flag < ActiveRecord::Base
  enum flag_type: [ :spam, :outdated, :misrepresentation, :not_real ]

  belongs_to :listing
  belongs_to :user

  default_scope -> { order('created_at DESC') }

  validates :flag_type, :user, :listing, presence: true
  validates_uniqueness_of :listing_id, :scope => :user_id, message: 'has already been flagged by you'

  class << self
    def strong_params
      [:flag_type, :comment, :listing_id]
    end
  end

end
