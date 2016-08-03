class AddColumnBodyRawToBlogPost < ActiveRecord::Migration
  def change
    add_column :blog_posts, :body_raw, :text
  end
end
