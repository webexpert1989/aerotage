class CommunitiesController < ApplicationController

  def index
    @communities = Community.all
  end

  def show
    @community = Community.friendly.find(params[:id])
    @jobs = Job.active.eager_loaded.in_community(@community.id)
  end

end