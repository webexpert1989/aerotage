class JobSeekersController < UsersController
layout 'login'
  private

    def user_class
      JobSeeker
    end

    def social_url
      create_social_job_seekers_path
    end

end
