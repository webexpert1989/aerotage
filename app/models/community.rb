class Community < ActiveRecord::Base
  include Fileable
  include Markdownable

  extend FriendlyId
  friendly_id :title, use: :slugged
  def should_generate_new_friendly_id?
    title_changed? || super
  end

  has_and_belongs_to_many :listings
  has_many :blog_posts

  has_one_file :image, :imageable, 'Image'
  has_markdown_field :content

  default_scope -> { order('title ASC') }

  validates :title, presence: true

  class << self

    def title_by_id(id)
      Community.find(id).title
    end

    def strong_params
      [:title, :brief_description, :specialties, :content_title, :content_raw, image_attributes: Image.strong_params]
    end

  end

end
