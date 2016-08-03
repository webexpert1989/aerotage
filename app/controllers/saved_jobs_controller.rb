class SavedJobsController < ApplicationController
  before_action :only_job_seeker
  before_action :find_saved_job, except: [:index]

  layout 'my_account', only: [:index]

  def index
    @saved_jobs = current_user.saved_jobs
  end

  def add
    current_user.saved_jobs << @job unless current_user.has_saved_job?(@job)
    render layout: false
  end

  def remove
    current_user.saved_jobs.delete(@job)
    redirect_to saved_jobs_path
  end

  private

    def find_saved_job
      @job = Job.find(params[:job_id])
    end

end
