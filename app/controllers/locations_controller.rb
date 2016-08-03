class LocationsController < ApplicationController

  def zip_code_info
    @locations = Location.where(zip_code: params[:zip_code])
    render layout: false
  end

end
