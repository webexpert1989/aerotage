module EmployersHelper

  def featured_employers(count = 3)
    featured_items = Employer.active.featured.limit(count).to_a
    Employer.where('id in (?)', featured_items.map{ |emp| emp.id }).reorder('').update_all(featured_last_shown: Time.now)
    featured_items
  end

  def featured_info(employer)
    option_info(employer.featured_until)
  end

  def resume_database_access_info(employer)
    option_info(employer.resume_database_access_until)
  end

  private

    def option_info(option_until)
      if option_until.present?
        if option_until > Time.now
          left = option_until - Time.now
          days = (left / 3600 / 24).ceil
          (days == 1 ? 'less than ' : '') + pluralize(days, 'day') + ' left'
        else
          'Expired'
        end
      else
        'No'
      end
    end

end
