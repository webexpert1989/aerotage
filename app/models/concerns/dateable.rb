module Dateable
  extend ActiveSupport::Concern

  module ClassMethods

    def has_date_field(*fields)
      fields.each do |field|
        define_method("#{field}") do
          read_attribute(field) ? read_attribute(field).to_formatted_s(:month_year) : ''
        end
        define_method("#{field}=") do |val|
          begin
            write_attribute(field, Date.strptime(val, '%B %Y').to_formatted_s(:db))
          rescue ArgumentError
            write_attribute(field, nil)
          end
        end
      end
    end
  end
end
