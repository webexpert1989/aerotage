class AddSummaryColumnToBlogPost < ActiveRecord::Migration
  def change
    add_column :blog_posts, :summary, :text
    add_column :blog_posts, :summary_raw, :text
  end
end
