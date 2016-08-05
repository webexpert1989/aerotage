class UserMailer < ActionMailer::Base

  def account_activation(user)
    @user = user
    mail to: user.email, subject: 'Account Activation'
  end

  def password_reset(user)
    @user = user
    mail to: user.email, subject: 'Password Reset Request'
  end

  def password_change(user)
    @user = user
    mail to: user.email, subject: 'Password Change'
  end

  def email_change_confirmation(user)
    @user = user
    mail to: user.new_email, subject: 'Email Change Confirmation'
  end

  def listing_alert(search, listings)
    @listings = listings
    @search = search
    mail to: search.user.email, subject: "#{@search.target_class} Alert"
  end

  def welcome(user)
    @user = user
    mail to: user.email, subject: 'Welcome to AerotageJobs!'
  end

  def new_application(application)
    @application = application
    mail to: application.employer.email, subject: "#{application.job.title} candidate - #{application.job_seeker.display_name} applied on AerotageJobs"
  end

  def new_message(message)
    @message = message
    @application = message.application
    mail to: message.to_employer? ? @application.employer.email : @application.job_seeker.email, subject: 'New Private Message'
  end

  def expired_listing(listing)
    @listing = listing
    @user = listing.user
    mail to: @user.email, subject: "Expired #{listing.to_s.capitalize} Posting"
  end

  def expiring_listing(listing)
    @listing = listing
    @user = listing.user
    mail to: @user.email, subject: "Expiring #{listing.to_s.capitalize}"
  end

  def expired_option(employer, option)
    @employer = employer
    @option = option
    mail to: employer.email, subject: "Expired '#{option}' Option"
  end

  def expiring_option(employer, option)
    @employer = employer
    @option = option
    mail to: employer.email, subject: "Expiring '#{option}' Option"
  end

end
