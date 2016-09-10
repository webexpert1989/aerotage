class StaticPagesController < ApplicationController

  def home
  render layout: 'home'
  end

  def about
  end

  def workingwithus
    render layout: 'static'
  end

  def faq
    render layout: 'static'
  end

  def about
    render layout: 'static'
  end

  def staffing_solutions
    render layout: 'static'
  end

  def technical_solutions
    render layout: 'static'
  end

  def engineering_solutions
    render layout: 'static'
  end

  def contact
    if request.post?
      contact_send
    else
      @contact_us = ContactUs.new

      if logged_in?
        @contact_us.name = current_user.employer? ? current_user.contact_name : current_user.display_name
        @contact_us.email = current_user.email
      end
    end
  end

  def contact_send
    @contact_us = ContactUs.new(params.require(:contact_us).permit(ContactUs.strong_params))

    valid = @contact_us.valid?
    if valid_captcha?(@contact_us) && valid
      @contact_us.send_email
      flash[:success] = 'Thank you very much for your message. We will respond to you as soon as possible.'
      redirect_to root_path
    end
    flash.delete(:recaptcha_error)
  end

  def privacy_policy
    render layout: false if params[:popup]
  end

  def terms_of_use
    render layout: false if params[:popup]
  end

end
