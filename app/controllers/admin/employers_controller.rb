class Admin::EmployersController < Admin::UsersController

  def featured
    success = Proc.new {
      resulting_featured_until = (@user.featured? ? @user.featured_until : Time.now) + (@action == 'add' ? @amount.days : -@amount.days)
      @user.update_attributes(featured_until: resulting_featured_until)

      render 'featured_success', layout: false
    }

    @options = {
        title: 'Manage Featured Option',
        amount_placeholder: 'Amount in days',
        url: featured_admin_employer_path(@user)
    }

    manage_dialog(success)
  end

  def resume_database_access
    success = Proc.new {
      resulting_until = (@user.has_resume_database_access? ? @user.resume_database_access_until : Time.now) + (@action == 'add' ? @amount.days : -@amount.days)
      @user.update_attribute(:resume_database_access_until, resulting_until)

      render 'resume_database_access_success', layout: false
    }

    @options = {
        title: 'Manage Resume Database Access Option',
        amount_placeholder: 'Amount in days',
        url: resume_database_access_admin_employer_path(@user)
    }

    manage_dialog(success)
  end

  private

    def find_user
      @user = Employer.friendly.find(params[:id])
    end

    def user_class
      Employer
    end

    def admin_users_path
      admin_employers_path
    end

    def admin_user_path(user)
      admin_employer_path(user)
    end

    def credits_admin_user_path
      credits_admin_employer_path(@user)
    end

end
