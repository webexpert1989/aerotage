class ListingsController < ApplicationController

  layout 'listings'

  def job_details
  end

  def job_search_results
  end

  def search
    search = Search.create(target_class: listing_class.name, conditions: params[:q])
    redirect_to search
  end

  def print
    if @listing.active || @listing.owner == current_user
      render layout: 'blank'
    else
      render :inactive
    end
  end

  def show
    render :inactive unless @listing.active
    @listing.increment!(:views) if @listing.active

    @referer = params[:referer]
    if params[:search_id]
      @search = Search.find_by_token(params[:search_id])

      @job_ransack = Job.ransack(@search.conditions) if @listing.job?
    end
  end

  def my
    @referer = 'my_listings'
    render :show
  end

  def new
    @listing = user_listings.new(location: current_user.location)
    @listing.build_file_properties if @listing.respond_to? :build_file_properties
  end

  def create
    @listing = user_listings.new(permit_params)

    if @listing.save
      flash[:success] = "'#{@listing.title}' #{@listing} created. Please activate it."
      redirect_to my_listing_path(@listing)
    else
      render :new
    end
  end

  def edit
    @listing.build_file_properties if @listing.respond_to? :build_file_properties
  end

  def update
    if @listing.update_attributes(permit_params)
      flash[:success] = "'#{@listing.title}' #{@listing} updated"
      redirect_to my_listing_path(@listing)
    else
      render :edit
    end
  end

  def destroy
    @listing.destroy
    redirect_to my_listings_path
  end

  def my_listings
    @listings = @search.result.page(params[:page])
  end

  def activate
    if @listing.activate
      flash[:success] = "'#{@listing.title}' #{@listing} activated"
    else
      flash[:danger] = "'#{@listing.title}' #{@listing} has expired and cannot be activated"
    end
    redirect_to my_listings_path
  end

  def deactivate
    @listing.deactivate
    flash[:success] = "'#{@listing.title}' #{@listing} deactivated"
    redirect_to my_listings_path
  end

  private

    def find_listing
      @listing = listing_class.friendly.find(params[:id])
    end

    def permit_params
      params.require(listing_class.name.underscore).permit(listing_class.strong_params)
    end

end
