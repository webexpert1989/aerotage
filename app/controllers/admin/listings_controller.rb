class Admin::ListingsController < Admin::AdminController
  before_action :find_listing, except: [:index, :new, :create]

  def index
    @search = listing_class.ransack(params[:q])
    @listings = @search.result.page(params[:page]).per(20)
  end

  def show
  end

  def edit
  end

  def update
    if @listing.update_attributes(permit_params)
      flash[:success] = "'#{@listing.title}' #{@listing} updated"
      redirect_to admin_listings_path
    else
      render :edit
    end
  end

  def destroy
    @listing.destroy
    flash[:success] = "'#{@listing.title}' #{@listing} deleted"
    redirect_to admin_listings_path
  end

  def manage
    success = Proc.new {
      resulting_active_until = (@listing.active ? @listing.active_until : Time.now) + (@action == 'add' ? @amount.days : -@amount.days)
      @listing.update_attributes(active: resulting_active_until > Time.now, active_until: resulting_active_until)

      render 'manage_success', layout: false
    }

    @options = {
        title: 'Manage Listing Activity Period',
        amount_placeholder: 'Amount in days',
        url: manage_admin_listing_path
    }

    manage_dialog(success)
  end

  private

    def find_listing
      @listing = listing_class.friendly.find(params[:id])
    end

    def permit_params
      params.require(listing_class.name.underscore).permit([:is_priority, :is_featured] + listing_class.strong_params)
    end

end
