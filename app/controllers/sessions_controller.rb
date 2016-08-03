class SessionsController < Devise::SessionsController
  before_action :guest_user, only: [:new, :create]
  def new
    super
  end

  def create
    self.resource = warden.authenticate!(auth_options)
    set_flash_message!(:notice, :signed_in)
    if sign_in(resource_name, resource)
        user = User.find_by(email: params[:user][:email].downcase)
        log_in user
    end

    yield resource if block_given?
    respond_with resource, location: after_sign_in_path_for(resource)
  end

#  def destroy
#  end

end