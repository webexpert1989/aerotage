Ransack.configure do |config|
  config.add_predicate 'date_gteq',
  arel_predicate: 'gteq',
  formatter: proc { |v| Date.strptime(v, '%b %d, %Y') },
  validator: proc { |v| v.present? },
  type: :string
end

Ransack.configure do |config|
  config.add_predicate 'date_lteq',
  arel_predicate: 'lteq',
  formatter: proc { |v| Date.strptime(v, '%b %d, %Y') },
  validator: proc { |v| v.present? },
  type: :string
end

Ransack.configure do |config|
  config.add_predicate 'within',
  arel_predicate: 'gteq',
  formatter: proc { |v| Date.today - v.to_i.days },
  validator: proc { |v| v.present? },
  type: :string
end

Ransack.configure do |config|
  config.add_predicate 'this',
  arel_predicate: 'gteq',
  formatter: proc { |v|
    if v == 'week'
      Date.beginning_of_week = :sunday
      Date.today.beginning_of_week
    elsif v == 'month'
      Date.today.beginning_of_month
    else
      Date.today
    end
  },
  validator: proc { |v| v.present? },
  type: :string
end

Ransack.configure do |config|
  config.add_predicate 'radius'
end
