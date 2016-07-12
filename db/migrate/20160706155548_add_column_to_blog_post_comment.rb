class AddColumnToBlogPostComment < ActiveRecord::Migration
  def change
    add_reference :blog_post_comments, :parent_comment, index: true
  end
end
