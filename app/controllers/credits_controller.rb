class CreditsController < ApplicationController
  before_action :logged_in_user
  before_action :find_listing, only: [:prolong_listing, :featured_listing, :priority_listing]
  before_action :find_user, except: [:purchase]
  before_action :define_credits, except: [:purchase]

  def buy
    render layout: false
  end

  def purchase
    @amount = params[:amount]
    @user = current_user.user
  end

  def charge
    @amount = params[:amount].to_i
    user = User.find(params[:user_id])

    customer = Stripe::Customer.create(
        :email => user.email,
        :description => user.display_name,
        :card  => params[:stripeToken]
    )

    Stripe::Charge.create(
        :customer    => customer.id,
        :amount      => @amount * 100,
        :description => "#{@amount} credits by #{user.display_name}",
        :currency    => 'usd'
    )

    user.update_attributes(credits: user.credits + @amount)

    user.transactions.create(
        transaction_type: :income,
        description: "Purchase #{@amount} credits",
        amount: @amount,
        balance: user.credits
    )

    flash[:success] = "You have successfully purchased #{@amount} credits"
    redirect_to my_credits_path
  rescue Stripe::CardError => e
    flash[:danger] = e.message
    redirect_to my_credits_path
  end

  def featured_employer
    option = '"Featured Employer" option'
    enabled = @user.featured?

    @action = smart_action(enabled, option)
    @price = Settings['products.featured_employer'].to_i
    @duration = '30 days'

    success = Proc.new {
      until_time = enabled ? @user.featured_until : Time.now
      @user.update_attributes(featured_until: until_time + 30.days, credits: @credits - @price)
      flash[:success] = smart_message(enabled, option)

      @user.transactions.create(
          transaction_type: :outcome,
          description: @action,
          amount: @price,
          balance: @user.credits
      )
    }

    activate_option(success, my_credits_path)
  end

  def resume_database_access
    option = '"Resume Database Access" option'
    enabled = @user.has_resume_database_access?

    @action = smart_action(enabled, option)
    @price = Settings['products.resume_database_access'].to_i
    @duration = '1 month'

    success = Proc.new {
      until_time = enabled ? @user.resume_database_access_until : Time.now
      @user.update_attributes(resume_database_access_until: until_time + 1.months, credits: @credits - @price)
      flash[:success] = smart_message(enabled, option)

      @user.transactions.create(
          transaction_type: :outcome,
          description: @action,
          amount: @price,
          balance: @user.credits
      )
    }

    activate_option(success, my_credits_path)
  end

  def prolong_listing
    option = @listing.display_name
    enabled = !@listing.never_activated?

    @action = smart_action(enabled, option)
    @price = Settings['products.' + @listing.to_s].to_i
    @duration = '30 days'
    @preserve_params = [:listing_id]

    success = Proc.new {
      until_time = @listing.expired? ? Time.now : @listing.active_until
      @listing.update_attributes(active: true, active_until: until_time + 30.days)
      @listing.update_attributes(first_activated_at: Time.now) if @listing.first_activated_at.nil?
      @user.update_attribute(:credits, @credits - @price)
      flash[:success] = smart_message(enabled, option)

      if @price > 0
        @user.transactions.create(
            transaction_type: :outcome,
            description: @action + " (ID: #{@listing.id})",
            amount: @price,
            balance: @user.credits
        )
      end
    }

    activate_option(success, my_listings_path(@listing))
  end

  def featured_listing
    activate_listing_option('featured')
  end

  def priority_listing
    activate_listing_option('priority')
  end

  private

    def find_listing
      @listing = Listing.find(params[:listing_id]).specific
    end

    def find_user
      if @listing
        @user = @listing.job? ? @listing.employer : @listing.job_seeker
      else
        @user = current_user
      end
    end

    def define_credits
      @credits = @user.credits
    end

    def my_listings_path(listing)
      listing.job? ? my_jobs_path : my_resumes_path
    end

    def smart_action(enabled, option)
      (enabled ? 'prolong' : 'activate') + ' ' + option
    end

    def smart_message(enabled, option)
      "You have successfully #{enabled ? 'prolonged' : 'activated'} #{option}"
    end

    def activate_listing_option(option)
      @price = Settings['products.' + option + '_' + @listing.to_s].to_i
      @action = 'make ' + @listing.display_name + ' ' + option.titleize
      @preserve_params = [:listing_id]

      success = Proc.new {
        @listing.update_attribute('is_' + option, true)
        @user.update_attribute(:credits, @credits - @price)
        flash[:success] = 'You have successfully made ' + @listing.display_name + ' ' + option.titleize

        @user.transactions.create(
            transaction_type: :outcome,
            description: @action + " (ID: #{@listing.id})",
            amount: @price,
            balance: @user.credits
        )
      }

      activate_option(success, my_listings_path(@listing))
    end

    def activate_option(success, back_path)
      if request.post?
        if @credits < @price
          flash[:danger] = 'You don\'t have enough credits to ' + @action
        else
          success.call
        end
        redirect_to back_path
      else
        render 'activate_option', layout: false
      end
    end

end
