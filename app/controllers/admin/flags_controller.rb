class Admin::FlagsController < Admin::AdminController

  def index
    @search = Flag.ransack(params[:q])
    @flags = @search.result.page(params[:page]).per(20)
  end

  def destroy
    flag = Flag.find(params[:id])
    flag.destroy
    flash[:success] = 'Flag removed'
    redirect_to admin_flags_path
  end

end
