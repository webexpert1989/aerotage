class JobsController < ListingsController
  before_action :only_employer, except: [:search, :show, :print, :in_location]
  before_action :find_listing, except: [:new, :create, :search, :in_location, :my_listings]
  before_action :correct_employer, only: [:my, :activate, :deactivate, :edit, :update, :destroy]

  before_action :add_recently_viewed_job, only: [:show]

  def my_listings
    @search = current_user.jobs.search(params[:q])
    super
  end

  def in_location
    @location = params[:location]
    converted_location = @location.gsub('-', ' ')
    parts = @location.split('-')

    if parts.size > 1 && parts.last.size == 2
      city_state_location(parts)
    elsif (result = Location.ransack(state_or_zip_code_matches_any: [@location, converted_location]).result.first)
      other_location(result, [@location.downcase, converted_location.downcase])
    else
      location_not_found
    end
  end

  def job_details
  end

  def job_search_results
  end

  private

    def add_recently_viewed_job
      current_user.add_recently_viewed_job(@listing) if @listing.active && logged_in? && current_user.job_seeker?
    end

    def city_state_location(parts)
      state_code = parts.pop
      city = parts.join('-')
      if (result = Location.ransack(city_matches_any: [city, city.gsub('-', ' ')], state_code_matches: state_code).result.select('city, state').first)
        @city = result.city
        @state = result.state
        @items = find_items(listing_location_city_eq: result.city, listing_location_state_eq: result.state)
        render :in_city_state
      else
        location_not_found
      end
    end

    def other_location(result, locations)
      if locations.include?(result.state.downcase)
        @state = result.state
        @items = find_items(listing_location_state_eq: result.state)
        render :in_state
      elsif locations.include?(result.zip_code.downcase)
        @zip_code = result.zip_code
        @items = find_items(listing_location_zip_code_eq: result.zip_code)
        render :in_zip_code
      else
        location_not_found
      end
    end

    def find_items(conditions)
      conditions[:listing_active_true] = '1'
      Job.ransack(conditions).result.page(params[:page])
    end

    def location_not_found
      raise Exceptions::NotFound.new unless @items
    end

    def listing_class
      Job
    end

    def my_listings_path
      my_jobs_path
    end

    def my_listing_path(listing)
      my_job_path(listing)
    end

    def user_listings
      current_user.jobs
    end

    def correct_employer
      deny_access unless @listing.employer == current_user
    end

end
