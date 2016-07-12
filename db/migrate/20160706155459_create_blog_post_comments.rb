class CreateBlogPostComments < ActiveRecord::Migration
  def change
    create_table :blog_post_comments do |t|
      t.references :commenter, polymorphic: true, index: true
      t.references :blog_post, index: true
      t.text :text

      t.timestamps
    end
  end
end
