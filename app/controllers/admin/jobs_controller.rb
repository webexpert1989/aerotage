class Admin::JobsController < Admin::ListingsController

  private

    def listing_class
      Job
    end

    def admin_listings_path
      admin_jobs_path
    end

    def manage_admin_listing_path
      manage_admin_job_path(@listing)
    end

end
