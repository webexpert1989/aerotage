class FixColumnName < ActiveRecord::Migration
  def change
    rename_column :blog_posts, :text, :body
  end
end
