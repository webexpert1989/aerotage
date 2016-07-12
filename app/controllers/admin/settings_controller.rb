class Admin::SettingsController < Admin::AdminController

  def products
    if request.post?
      params[:settings].each do |key, value|
        Settings[key] = value
      end
      flash.now['success'] = 'Products Settings have been successfully saved'
    end
  end

  def admin_password
    if request.post?
      current_password = params[:current_password]
      password = params[:password]
      password_confirmation = params[:password_confirmation]

      begin
        if password.present? && password == password_confirmation && BCrypt::Password.new(Settings[:admin_password]) == current_password
          Settings[:admin_password] = BCrypt::Password.create(password).to_s
          flash.now['success'] = 'Admin Password updated'
        else
          flash.now['danger'] = 'Invalid data entered'
        end
      rescue BCrypt::Errors::InvalidHash
        flash.now['danger'] = 'Current Admin Password is corrupted'
      end
    end
  end

end
