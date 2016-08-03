class UsersController < ApplicationController
  before_action :logged_in_user, only: [:my_account, :edit_profile, :destroy]
  #before_action :guest_user, only: [:new, :create, :social_login, :create_social]
  before_action :find_user, only: [:my_account, :edit_profile, :my_credits, :destroy]

  layout 'my_account', only: [:my_account, :my_credits]

  def new
    @user = user_class.new
    @user.build_file_properties
  end

  def create
    @user = user_class.new(permit_params)
    @user.valid?
    if valid_captcha?(@user) && @user.save
      @user.send_activation_email
      flash[:info] = 'Please check your email to activate your account.'
      redirect_to root_url
    else
      flash.delete(:recaptcha_error)
      @log = @user.errors.full_messages
      render :new
    end
  end

  def social_login
    auth_hash = request.env['omniauth.auth']
    email = auth_hash.info.email
    user = User.find_by_email(email)

    if user
      user.activate unless user.activated
      log_in user
      redirect_back_or my_account_path
    else
      @job_seeker = JobSeeker.new(email: email, first_name: auth_hash.info.first_name, last_name: auth_hash.info.last_name)
      @employer = Employer.new(email: email)
      render :new_social_choose_group
    end
  end

  def create_social
    @url = social_url
    @user = user_class.new(permit_params)
    @user.password = SecureRandom.hex

    if !params[:initial].present? && @user.save
      @user.activate
      log_in @user.user
      flash[:success] = 'You have successfully registered on our job board. You can fill additional info below now'
      redirect_to edit_profile_path
    else
      flash.now[:warning] = 'Please check per-filled fields below and fill missing required fields' if params[:initial].present?
      render :new_social
    end
  end

  def my_account
    render @user.class.name.underscore.pluralize + '/my_account'
  end

  def edit_profile
    if request.get?
      @user.email_confirmation = @user.email
      @user.build_file_properties
    elsif @user.update_attributes(params.require(@user.class.name.underscore).permit(@user.class.strong_params))
      flash[:success] = 'Profile updated'
      redirect_to my_account_path
    end
  end

  def destroy
    current_user.destroy
    flash[:success] = 'Your account was successfully deleted'
    redirect_to root_path
  end

  def my_credits
  end

  private

    def find_user
      @user = current_user
    end

    def permit_params
      params.require(user_class.name.underscore).permit(user_class.strong_params)
    end

end
