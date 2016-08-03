class FlagsController < ApplicationController
  before_action :logged_in_user
  before_action :find_listing, only: [:new]

  def new
    @flag = current_user.user.flags.new(listing: @listing)
    render layout: false
  end

  def create
    @flag = current_user.user.flags.new(permit_params)
    if @flag.save
      render 'flag_success', layout: false
    else
      render :new, layout: false
    end
  end

  private

    def find_listing
      @listing = Listing.find(params[:listing_id])
    end

    def permit_params
      params.require(:flag).permit(Flag.strong_params)
    end

end
