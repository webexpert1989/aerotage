class SearchesController < ApplicationController
  before_action :logged_in_user, except: [:show, :undo_criterion]
  before_action :find_search, except: [:saved]

  before_action :allowed_resume_search, only: [:show]
  before_action :correct_user, only: [:edit, :update, :destroy]

  layout 'my_account', only: [:saved]

  def show
    target_class = search_class(@search)

    if target_class == Job
      @job_ransack = target_class.ransack(@search.conditions)
    else
      @search.conditions['hidden_false'] = 1
    end
    @search.conditions['listing_active_true'] = 1
    target_class = target_class.eager_loaded.reorder('listings.is_priority DESC, listings.first_activated_at DESC')
    result = Location.search_listings_with_location(target_class, @search.conditions)
    @items = result.page(params[:page])
  end

  def edit
    render layout: false
  end

  def update
    @search.user = current_user.user
    @search.last_sent = Time.now
    if @search.update_attributes(permit_params)
      render params[:referer] == 'search' ? 'save_search_success' : 'edit_search_success', layout: false
    else
      render :edit, layout: false
    end
  end

  def destroy
    @search.destroy
    redirect_to saved_searches_path
  end

  def saved
    @searches = current_user.searches
  end

  def undo_criterion
    if params[:value].present?
      @search.conditions[params[:condition]].delete(params[:value])
    elsif params[:condition] == 'smart_location'
      @search.conditions['smart_location_eq'] = ''
      @search.conditions['smart_location_radius'] = ''
    else
      @search.conditions[params[:condition]] = ''
    end
    @search.save
    redirect_to @search
  end

  private

    def find_search
      @search = Search.find_by_token(params[:id])
    end

    def allowed_resume_search
      check_resume_database_access if search_class(@search) == Resume
    end

    def correct_user
      deny_access if @search.user.present? && @search.user != current_user.user
    end

    def permit_params
      params.require(:search).permit(Search.strong_params)
    end

    def search_class(search)
      return Job if search.target_class == 'Job'
      return Resume if search.target_class == 'Resume'
      deny_access
    end

end
