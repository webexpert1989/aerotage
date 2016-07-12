class Search < ActiveRecord::Base
  serialize :conditions, JSON

  belongs_to :user

  before_create :generate_token

  default_scope -> { order('created_at DESC') }

  enum frequency: [ :daily, :weekly, :monthly ]

  validates :title, presence: true, if: :user_id?

  def to_param
    token
  end

  class << self

    def strong_params
      [:title, :frequency, :active]
    end

  end

  private

    def generate_token
      self.token = loop do
        random_token = SecureRandom.urlsafe_base64(nil, false)
        break random_token unless Search.exists?(token: random_token)
      end
    end

end
