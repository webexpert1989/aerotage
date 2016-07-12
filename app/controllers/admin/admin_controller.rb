class Admin::AdminController < ApplicationController
  layout 'admin'

  before_action :logged_in_admin

  def manage_dialog(success)
    @action = params[:manage_action]
    @amount = Integer(params[:amount]) rescue nil
    if @action
      if @amount && @amount > 0
        success.call
        return
      else
        @errors = ['Amount should be positive number']
      end
    end

    render 'admin/shared/manage_dialog', layout: false
  end

  private

    def logged_in_admin
      unless admin_logged_in?
        redirect_to admin_login_path
      end
    end

end
