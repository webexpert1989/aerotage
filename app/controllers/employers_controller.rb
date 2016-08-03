class EmployersController < UsersController

  def show
    @employer = Employer.friendly.find(params[:company])
    @limit = params[:limit] || 10
    @jobs = @employer.jobs.eager_loaded.page(params[:page]).per(@limit)
  end

  private

    def user_class
      Employer
    end

    def social_url
      create_social_employers_path
    end

end
