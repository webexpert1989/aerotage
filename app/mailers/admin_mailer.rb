class AdminMailer < ActionMailer::Base
  default to: 'admin@aerotagejobs.com'

  def contact_us(contact_us)
    @contact_us = contact_us
    mail reply_to: contact_us.email, subject: "Contact Us message from #{contact_us.name}"
  end

end
