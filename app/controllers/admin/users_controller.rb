class Admin::UsersController < Admin::AdminController
  before_action :find_user, except: [:index, :new, :create]

  def index
    @search = user_class.ransack(params[:q])
    @users = @search.result.page(params[:page]).per(10)
  end

  def show
  end

  def new
    @user = user_class.new
    @user.build_file_properties
  end

  def create
    @user = user_class.new(permit_params)
    if @user.save
      flash[:success] = "The #{@user} was successfully created. Please Activate it manually"
      redirect_to admin_users_path
    else
      render :new
    end
  end

  def edit
    @user.build_file_properties
  end

  def update
    if @user.update_attributes(permit_params)
      flash[:success] = "The #{@user} was successfully updated"
      redirect_to admin_user_path(@user)
    else
      render :edit
    end
  end

  def destroy
    @user.destroy
    flash[:success] = "The #{@user} was successfully deleted"
    redirect_to admin_users_path
  end

  def activate
    @user.activate
    flash[:success] = "The #{@user} was successfully activated"
    redirect_to admin_users_path
  end

  def deactivate
    @user.deactivate
    flash[:success] = "The #{@user} was successfully deactivated"
    redirect_to admin_users_path
  end

  def login
    if @user.activated?
      user = @user.user
      log_in user
      forget(user)
      redirect_to my_account_path
    else
      flash[:warning] = 'Account not activated. You need to activate account before login'
      redirect_to admin_users_path
    end
  end

  def credits
    success = Proc.new {
      if @action == 'subtract' && @amount > @user.credits
        @amount = @user.credits
      end

      resulting_credits = @user.credits + (@action == 'add' ? @amount : -@amount)
      @user.update_attributes(credits: resulting_credits)

      @user.transactions.create(
          transaction_type: (@action == 'add' ? :income : :outcome),
          description: "Credits #{@action == 'add' ? 'given' : 'taken'} by Administrator",
          amount: @amount,
          balance: resulting_credits
      )

      render 'credits_success', layout: false
    }

    @options = {
        title: 'Manage Credits',
        amount_placeholder: 'Amount',
        url: credits_admin_user_path
    }

    manage_dialog(success)
  end

  private

    def find_user
      @user = user_class.find(params[:id])
    end

    def permit_params
      params.require(user_class.name.underscore).permit(user_class.strong_params)
    end

end
