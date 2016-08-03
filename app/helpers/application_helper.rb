module ApplicationHelper

  def full_title(page_title = '')
    base_title = 'AerotageJobs'
    page_title.empty? ? base_title : "#{page_title} | #{base_title}"
  end

  def current_user_class
    if logged_in?
      current_user.employer? ? ' employer' : ' job_seeker'
    end
  end

  def object_name(object)
    object.class.to_s.underscore
  end

  def object_title(object)
    object.class.name.titleize
  end

  def object_path(object)
    object.class.name.underscore.pluralize
  end

  def controller?(controller)
    controller.to_s == params[:controller]
  end

  def action?(controller, *actions)
    controller.to_s == params[:controller] && actions.collect{ |action| action.to_s }.include?(params[:action])
  end

  def formatted_location(listing)
    listing.location.city + ', ' + listing.location.state + ', ' + listing.location.country
  end

  def formatted_location_with_zip(listing)
    listing.location.zip_code + ', ' + formatted_location(listing)
  end

  def include_script(script)
    @scripts ||= []
    @scripts << script unless @scripts.include?(script)
    content_for :scripts, @scripts.map{ |s| s + '-js' }.join(' '), { flush: true }
  end

end
