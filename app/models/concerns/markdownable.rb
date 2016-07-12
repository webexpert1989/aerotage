module Markdownable
  extend ActiveSupport::Concern

  included do
    class_attribute :markdown_fields

    private

      def parse_markdown_fields
        renderer = Redcarpet::Render::HTML.new(filter_html: true, no_images: true, no_links: true, no_styles: true)
        markdown = Redcarpet::Markdown.new(renderer, no_intra_emphasis: true)

        markdown_fields.each do |field|
          raw = send("#{field}_raw")
          if raw
            parsed = Sanitize.fragment(markdown.render(raw), elements: %w(strong em p ol ul li))
            self.send("#{field}=", parsed)
          end
        end
      end

  end

  module ClassMethods

    def has_markdown_field(field)
      before_save :parse_markdown_fields

      self.markdown_fields ||= []
      self.markdown_fields << field
    end

  end

end
