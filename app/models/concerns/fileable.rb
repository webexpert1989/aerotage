module Fileable
  extend ActiveSupport::Concern

  included do
    class_attribute :fields

    def build_file_properties
      fields.each do |field|
        send("build_#{field}") if send(field).nil?
      end
    end

    private

      def sync_file_properties
        fields.each do |field|
          self.send("#{field}=", nil) unless send(field).nil? || send(field).stored?
        end
      end

  end

  module ClassMethods

    def has_one_file(field, as, class_name)
      has_one field, as: as, class_name: class_name, dependent: :destroy
      accepts_nested_attributes_for field, allow_destroy: true

      before_validation :sync_file_properties
      after_validation :build_file_properties
      before_save :sync_file_properties

      self.fields ||= []
      self.fields << field
    end

  end

end
