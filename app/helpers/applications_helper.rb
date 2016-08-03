module ApplicationsHelper

  def already_applied?(job)
    logged_in? && current_user.job_seeker? && current_user.applications.where(job: job).exists?
  end

end
