module BlogPostsHelper
  def archive_list
    ActiveRecord::Base.connection.execute("SELECT to_char(created_at, 'FMMonth YYYY') as str, EXTRACT(MONTH FROM created_at) AS month, EXTRACT(YEAR FROM created_at) AS year FROM \"blog_posts\" GROUP BY str, month, year ORDER BY YEAR DESC, MONTH DESC")
  end

  def latest_posts
    BlogPost.limit 6
  end
end