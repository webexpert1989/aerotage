class SavedResumesController < ApplicationController
  before_action :only_employer
  before_action :find_saved_resume, except: [:index]

  layout 'my_account', only: [:index]

  def index
    @saved_resumes = current_user.saved_resumes
  end

  def add
    current_user.saved_resumes << @resume unless current_user.has_saved_resume?(@resume)
    render layout: false
  end

  def remove
    current_user.saved_resumes.delete(@resume)
    redirect_to saved_resumes_path
  end

  private

    def find_saved_resume
      @resume = Resume.find(params[:resume_id])
    end

end
