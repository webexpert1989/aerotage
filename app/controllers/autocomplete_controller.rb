class AutocompleteController < ApplicationController
  before_action :find_term
  before_action { @limit = 20 }

  def zip_code
    locations = @term ? locations_starting_with(@term, :zip_code) : []

    render json: locations.to_json
  end

  def location
    locations = []

    if @term
      if /\A[-+]?\d+\z/ === @term
        locations += locations_starting_with(@term, :zip_code)
      else
        locations += locations_starting_with(@term, :state)
        locations += locations_starting_with(@term, :city, Proc.new { |i| i[:city] + ', ' + i[:state_code] }, [:city, :state_code]) if @limit > 0
      end
    end

    render json: locations.to_json
  end

  def jobs
    items = []

    if @term
      items += listings_starting_with(@term, Job)

      if @limit > 0
        result = Employer.unscoped.select(:company_name).ransack(company_name_start: @term).result(distinct: true).limit(@limit)
        items += result.collect { |i| { id: nil, value: i[:company_name] } }
      end
    end

    render json: items.to_json
  end

  def resumes
    items = []
    items += listings_starting_with(@term, Resume) if @term
    render json: items.to_json
  end

  private

    def find_term
      @term = params[:term]
    end

    def locations_starting_with(term, field, custom_map = nil, custom_fields = nil)
      criterion = field.to_s + '_start'
      order = custom_fields ? custom_fields.join(', ') : field
      result = Location.select(custom_fields || field).search(criterion => term).result(distinct: true).order(order).limit(@limit)
      locations = result.collect { |i| { id: nil, value: custom_map ? custom_map.call(i) : i[field] } }
      @limit -= locations.size
      locations
    end

    def listings_starting_with(term, listing_class)
      result = listing_class.unscoped.select('listings.title').ransack(listing_title_start: term).result(distinct: true).limit(@limit)
      items = result.collect { |i| { id: nil, value: i[:title] } }
      @limit -= items.size
      items
    end

end
