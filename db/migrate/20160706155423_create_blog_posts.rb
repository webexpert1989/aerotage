class CreateBlogPosts < ActiveRecord::Migration
  def change
    create_table :blog_posts do |t|
      t.string :title
      t.text :text
      t.string :author
      t.references :community, index: true

      t.timestamps
    end
  end
end
