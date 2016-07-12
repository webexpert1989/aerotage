class Admin::JobSeekersController < Admin::UsersController

  private

  def user_class
    JobSeeker
  end

  def admin_users_path
    admin_job_seekers_path
  end

  def admin_user_path(user)
    admin_job_seeker_path(user)
  end

  def credits_admin_user_path
    credits_admin_job_seeker_path(@user)
  end

end
