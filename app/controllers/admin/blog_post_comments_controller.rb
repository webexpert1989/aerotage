class Admin::BlogPostCommentsController < Admin::AdminController
  before_action :set_params, only: [:edit, :update, :destroy]

  def index
    @post = BlogPost.friendly.find(params[:blog_post_id])
    @comments = @post.comments.where(parent_comment: nil)
  end

  def update
    if @comment.update_attributes(permit_params)
      flash[:success] = 'The blog post comment was successfully updated'
      redirect_to admin_blog_post_comments_path @comment.blog_post
    else
      render :edit
    end
  end

  def destroy
    @comment.destroy
    flash[:success] = 'The blog post comment was successfully deleted'
    redirect_to admin_blog_post_comments_path @post
  end

  private
    def set_params
      @comment = BlogPostComment.find(params[:id])
      @post = @comment.blog_post
    end

    def permit_params
      params.require(:blog_post_comment).permit(BlogPostComment.strong_params)
    end
end
