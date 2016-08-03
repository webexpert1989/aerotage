class User < ActiveRecord::Base
  # attr_accessible :name, :email, :password, :password_confirmation, :provider, :uid
  actable

  belongs_to :location
  has_many :searches, dependent: :destroy
  has_many :flags, dependent: :destroy
  has_many :transactions, dependent: :destroy

  attr_accessor :remember_token, :activation_token, :reset_token, :reset_password_action
  
  enum role: [:guest, :associate, :admin]
  after_initialize :set_default_role, :if => :new_record?

  after_initialize :set_default_values
  before_save :downcase_email
  before_create :create_activation_digest

  validates :email, presence: true, confirmation: true, uniqueness: { case_sensitive: false }
  validates_format_of :email, with: VALID_EMAIL_REGEX, allow_blank: true

  #has_secure_password
  validates :password, length: { minimum: 6 }, if: -> { new_record? || reset_password_action }

  validates :location_id, presence: false
  validates :terms, presence: true
  validates :terms, acceptance: { message: 'of Use and Privacy Policy must be accepted' }



  def set_default_role
    self.role ||= :guest
  end

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable,
         :omniauth_providers => [:facebook, :google_oauth2, :twitter]

  def self.find_for_facebook_oauth(auth, signed_in_resource=nil)
    user = User.where(:provider => auth.provider, :uid => auth.uid).first
    if user
      return user
    else
      registered_user = User.where(:email => auth.info.email).first
      if registered_user
        return registered_user
      else
        user = User.create(name:auth.extra.raw_info.name,
          provider:auth.provider,
          uid:auth.uid,
          email:auth.info.email,
          password:Devise.friendly_token[0,20]
        )
      end
       
    end
  end

  def self.find_for_google_oauth2(access_token, signed_in_resource=nil)
    data = access_token.info
    user = User.where(:provider => access_token.provider, :uid => access_token.uid ).first
    if user
      return user
    else
      registered_user = User.where(:email => access_token.info.email).first
      if registered_user
        return registered_user
      else
        user = User.create(name: data["name"],
          provider:access_token.provider,
          email: data["email"],
          uid: access_token.uid ,
          password: Devise.friendly_token[0,20]
        )
      end
   end
  end

  def self.find_for_twitter_oauth(auth, signed_in_resource=nil)
 
    user = User.where(:provider => auth.provider, :uid => auth.uid).first
    if user
      return user
    else
      registered_user = User.where(:email => auth.uid + "@twitter.com").first
      if registered_user
        return registered_user
      else
        user = User.create(name:auth.info.name,
          provider:auth.provider,
          uid:auth.uid,
          email:auth.uid+"@twitter.com",
          password:Devise.friendly_token[0,20]
        )
      end
    end
  end

  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  def authenticated?(attribute, token)
    digest = send("#{attribute}_digest")
    digest && BCrypt::Password.new(digest).is_password?(token)
  end

  def forget
    update_attribute(:remember_digest, nil)
  end

  def activate
    update_attribute(:activated, true)
    update_attribute(:activated_at, Time.zone.now)
  end

  def deactivate
    update_attribute(:activated, false)
  end

  def send_activation_email
    UserMailer.account_activation(self).deliver
  end

  def send_email_change_email(new_email)
    create_activation_digest
    self.new_email = new_email
    self.save
    UserMailer.email_change_confirmation(self).deliver
  end

  def create_reset_digest
    self.reset_token = User.new_token
    update_attribute(:reset_digest, User.digest(reset_token))
    update_attribute(:reset_sent_at, Time.zone.now)
  end

  def send_password_reset_email
    UserMailer.password_reset(self).deliver
  end

  def password_reset_expired?
    reset_sent_at < 2.hours.ago
  end

  def job_seeker?
    specific.class == JobSeeker
  end

  def employer?
    specific.class == Employer
  end

  def display_name
    specific.display_name
  end

  class << self

    def digest(string)
      cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
      BCrypt::Password.create(string, cost: cost)
    end

    def new_token
      SecureRandom.urlsafe_base64
    end

    def strong_params
      [:email, :email_confirmation, :password, :password_confirmation, :send_mailings, :terms, :location_id, :address]
    end

  end

  private

    def set_default_values
      self.send_mailings = true if self.send_mailings.nil?
    end

    def downcase_email
      self.email.downcase!
    end

    def create_activation_digest
      self.activation_token = User.new_token
      self.activation_digest = User.digest(activation_token)
    end

end
