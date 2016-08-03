class ResumesController < ListingsController
  before_action :only_job_seeker, except: [:show, :print, :search_form, :search, :download]
  before_action :only_employer, only: [:search_form, :search]
  before_action :find_listing, except: [:new, :create, :search_form, :search, :my_listings]

  before_action :correct_job_seeker, only: [:activate, :deactivate, :edit, :update, :destroy]

  before_action :logged_in_user, only: [:show, :print, :download]
  before_action :correct_job_seeker, only: [:show, :print, :download], if: -> { current_user.job_seeker? }
  before_action :visible_resume, only: [:show, :print, :download], if: -> { current_user.employer? }

  before_action :check_resume_database_access, only: [:search_form, :search]

  def download
    redirect_to @listing.resume.remote_url
  end

  def search_form
    search = Search.find_by_token(params[:search_id])
    @resume_ransack = Resume.ransack(search ? search.conditions : nil)
  end

  def my_listings
    @search = current_user.resumes.ransack
    super
  end

  private

    def listing_class
      Resume
    end

    def my_listings_path
      my_resumes_path
    end

    def my_listing_path(listing)
      my_resume_path(listing)
    end

    def user_listings
      current_user.resumes
    end

    def correct_job_seeker
      deny_access unless @listing.job_seeker == current_user
    end

    def visible_resume
      unless current_user.can_view_resume?(@listing)
        check_resume_database_access
        render :hidden_resume if @listing.hidden
      end
    end

end
