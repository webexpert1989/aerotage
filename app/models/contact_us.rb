class ContactUs
  include ActiveModel::Validations
  include ActiveModel::Conversion

  attr_accessor :name, :email, :comments, :comments_raw

  validates :name, :email, :comments, presence: true
  validates_format_of :email, with: VALID_EMAIL_REGEX, allow_blank: true

  def initialize(attributes = {})
    attributes.each do |name, value|
      send("#{name}=", value)
    end
  end

  def send_email
    parse_markdown_field
    AdminMailer.contact_us(self).deliver
  end

  def parse_markdown_field
    renderer = Redcarpet::Render::HTML.new(filter_html: true, no_images: true, no_links: true, no_styles: true)
    markdown = Redcarpet::Markdown.new(renderer, no_intra_emphasis: true)
    self.comments_raw = comments
    self.comments = Sanitize.fragment(markdown.render(comments), elements: %w(strong em p ol ul li))
  end

  class << self
    def strong_params
      [:name, :email, :comments]
    end
  end

end
