class BlogPostCommentsController < ApplicationController
  before_action :set_params
  before_action :require_logged_in_user
  layout false

  def new
    @blog_post_comment = @blog_post.comments.new
  end

  def create
    @blog_post_comment = @blog_post.comments.new(permit_params)
    @blog_post_comment.commenter = current_user
    @blog_post_comment.parent_comment = @parent_comment

    if @blog_post_comment.save
      render :create_success
    else
      render :new
    end
  end

  private
    def require_logged_in_user
      return true if logged_in?
      render :login_required
    end

    def set_params
      @blog_post = BlogPost.friendly.find(params[:blog_post_id])
      @parent_comment = BlogPostComment.find(params[:parent_comment_id]) if params[:parent_comment_id]
    end

    def permit_params
      params.require(:blog_post_comment).permit(BlogPostComment.strong_params)
    end
end
