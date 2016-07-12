class Admin::CommunitiesController < Admin::AdminController
  before_action :find_community, except: [:index, :new, :create]

  def index
    @communities = Community.all
  end

  def new
    @community = Community.new
    @community.build_file_properties
  end

  def create
    @community = Community.new(permit_params)
    if @community.save
      flash[:success] = 'The community was successfully created'
      redirect_to admin_communities_path
    else
      render 'new'
    end
  end

  def edit
    @community.build_file_properties
  end

  def update
    if @community.update_attributes(permit_params)
      flash[:success] = 'The community was successfully updated'
      redirect_to admin_communities_path
    else
      render 'edit'
    end
  end

  def destroy
    @community.destroy
    flash[:success] = 'The community was successfully deleted'
    redirect_to admin_communities_path
  end

  private

    def find_community
      @community = Community.find_by_slug(params[:id])
    end

    def permit_params
      params.require(:community).permit(Community.strong_params)
    end

end