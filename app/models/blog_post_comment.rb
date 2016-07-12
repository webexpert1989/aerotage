class BlogPostComment < ActiveRecord::Base
  belongs_to :commenter, polymorphic: true
  belongs_to :blog_post
  belongs_to :parent_comment, class_name: 'BlogPostComment'
  has_many :replies, class_name: 'BlogPostComment', foreign_key: :parent_comment_id, dependent: :destroy

  default_scope { order('created_at ASC') }

  validates :text, presence: true

  class << self
    def strong_params
      [:text]
    end
  end
end
