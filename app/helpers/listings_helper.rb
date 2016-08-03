module ListingsHelper

  def employment_types_list(listing)
    listing.employment_types.map{ |employment_type| employment_type.title }.join(', ')
  end

  def communities_list(listing)
    listing.communities.map{ |community| community.title }.join(', ')
  end

  def occupations_list(listing)
    listing.occupations.map{ |occupation| occupation.title }.join(', ')
  end

  def grouped_tree_nodes(nodes)
    tree_nodes = []
    nodes.each do |tree_node|
      current = tree_nodes
      tree_node.ancestors.each do |ancestor|
        exists = false
        current.each do |node|
          if node[:item] == ancestor
            exists = true
            current = node[:children]
            break
          end
        end
        unless exists
          item = { item: ancestor, children: [] }
          current << item
          current.sort_by!{ |node| node[:item].title }
          current = item[:children]
        end
      end
      current << { item: tree_node, children: [] }
    end
    tree_nodes
  end

  def formatted_salary(listing)
    listing.salary && listing.salary_type ? number_to_currency(listing.salary, unit: '$', precision: 0) + ' ' + listing.salary_type  : nil
  end

  def listing_options(listing)
    options = []
    options << 'Priority' if listing.priority?
    options << 'Featured' if listing.featured?
    options.join(', ')
  end

  def listing_activity_info(listing)
    if listing.active_until.present?
      left = listing.active_until - Time.now

      if left > 0
        days = (left / 3600 / 24).ceil
        (listing.active ? 'Active' : 'Inactive') + ': ' + (days == 1 ? 'less than ' : '') + pluralize(days, 'day') + ' left'
      else
        'Expired' + (listing.active ? ' (still active)' : '')
      end
    else
      'Never activated'
    end
  end
end
              