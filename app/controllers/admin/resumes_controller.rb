class Admin::ResumesController < Admin::ListingsController
  before_action :find_listing, except: [:index, :new, :create]

  private

  def listing_class
    Resume
  end

  def admin_listings_path
    admin_resumes_path
  end

  def manage_admin_listing_path
    manage_admin_resume_path(@listing)
  end

end
