module SearchesHelper

  def search_criteria(search)
    all_criteria = []

    search.conditions.each do |condition, value|
      all_criteria += criteria(condition, value)
    end

    all_criteria
  end

  def criteria(condition, value)
    if value.present?
      case condition
        when 'listing_communities_id_in'
          multi_criteria(condition, value, Community)
        when 'listing_occupations_id_in'
          multi_criteria(condition, value, Occupation)
        when 'listing_employment_types_id_in'
          multi_criteria(condition, value, EmploymentType)
        when 'listing_activated_at_within'
          single_criterion(condition, 'posted within ' + pluralize(value, ' day'))
        when 'listing_salary_gteq'
          single_criterion(condition, 'salary greater than ' + number_to_currency(value, unit: '$'))
        when 'listing_salary_lteq'
          single_criterion(condition, 'salary less than ' + number_to_currency(value, unit: '$'))
        when 'listing_salary_type_eq'
          single_criterion(condition, 'salary type: ' + value)
        when 'listing_active_true'
          []
        when 'hidden_false'
          []
        else
          single_criterion(condition, value)
      end
    else
      []
    end
  end

  def single_criterion(condition, display_value)
    [{ display_value: display_value, condition: condition, value: nil }]
  end

  def multi_criteria(condition, values, source)
    criteria = []

    values.each do |v|
      criteria << { display_value: source.title_by_id(v), condition: condition, value: v } if v.present?
    end

    criteria
  end

  def extract_tree_values(ransack, condition)
    ransack.conditions.each do |c|
      if c.attributes.first.name == condition.to_s
        return c.values.map{ |v| v.value }.reject!(&:empty?).map(&:to_i)
      end
    end
    []
  end

end
