class BlogPost < ActiveRecord::Base
  include Fileable
  include Markdownable

  extend FriendlyId
  friendly_id :slug_candidates, use: :slugged
  def slug_candidates
    [:title, [:title, :community_name]]
  end
  def should_generate_new_friendly_id?
    title_changed? || super
  end

  belongs_to :community
  has_many :comments, class_name: 'BlogPostComment', dependent: :destroy
  has_one_file :image, :imageable, 'Image'
  has_markdown_field :summary
  has_markdown_field :body

  default_scope { order('created_at DESC') }

  validates :title, :summary_raw, :body_raw, :community, presence: true

  def community_name
    community.title
  end

  class << self
    def strong_params
      [:title, :author, :summary_raw, :body_raw, :community_id, image_attributes: Image.strong_params]
    end
  end
end
