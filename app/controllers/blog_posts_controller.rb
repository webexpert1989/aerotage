class BlogPostsController < ApplicationController

  def index
    # @limit = params[:limit] || 10
    # @community = Community.friendly.find(params[:community_id]) if params[:community_id]

    # @blog_posts = BlogPost
    # @blog_posts = @blog_posts.where('extract(year from created_at) = ? and extract(month from created_at) = ?', params[:year], params[:month]) if params[:year] and params[:month]
    # @blog_posts = @blog_posts.ransack(community_id_eq: @community.id).result if @community

    # @blog_post_ransack = @blog_posts.ransack(params[:q])
    # @blog_posts = @blog_post_ransack.result.page(params[:page]).per(@limit)
  end

  def show
    # @blog_post_ransack = BlogPost.ransack(params[:q])
    # @blog_post = BlogPost.friendly.find(params[:id])
  end

end
