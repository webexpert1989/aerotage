class Admin::SessionsController < ApplicationController
  before_action :guest_admin, only: [:new, :create]
  layout 'admin_login'

  def new
  end

  def create
    if params[:session][:login] == 'admin' && BCrypt::Password.new(Settings[:admin_password]) == params[:session][:password]
      log_in_admin
      redirect_to admin_path
    else
      @error = 'Invalid login/password combination'
      render 'new'
    end
  end

  def destroy
    session.delete(:admin_logged_in)
    redirect_to admin_login_path
  end

  private

    def guest_admin
      if admin_logged_in?
        redirect_to admin_path
      end
    end

end
