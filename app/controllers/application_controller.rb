class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  include SessionsHelper
  protected

    def logged_in_user
      unless logged_in?
        store_location
        raise Exceptions::NotAuthenticated.new
      end
    end

    def guest_user
      raise Exceptions::AlreadyAuthenticated.new if logged_in?
    end

    def only_job_seeker
      deny_access unless user_signed_in? || current_user.job_seeker?
    end

    def only_employer
      #deny_access unless user_signed_in? || current_user.employer?
    end

    def check_resume_database_access
      only_employer
      unless current_user.has_resume_database_access?
        flash[:danger] = 'You need to enable "Resume Database Access" option in order to access this page'
        redirect_to my_credits_path
      end
    end

    def valid_captcha?(model)
      Rails.env.development? || verify_recaptcha(model: model, message: 'reCaptcha validation failed')
    end

  private

    def deny_access
      raise Exceptions::AccessDenied.new
    end
end



