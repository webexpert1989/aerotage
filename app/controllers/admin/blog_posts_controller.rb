class Admin::BlogPostsController < Admin::AdminController
  before_action :find_blog_post, except: [:index, :new, :create]

  def index
    @posts = BlogPost.all
  end

  def new
    @post = BlogPost.new
    @post.build_file_properties
  end

  def create
    @post = BlogPost.new permit_params
    if @post.save
      flash[:success] = 'The blog post was successfully created'
      redirect_to admin_blog_posts_path
    else
      render 'new'
    end
  end

  def edit
    @post.build_file_properties
  end

  def update
    if @post.update_attributes(permit_params)
      flash[:success] = 'The blog post was successfully updated'
      redirect_to admin_blog_posts_path
    else
      render 'edit'
    end
  end

  def destroy
    @post.destroy
    flash[:success] = 'The blog post was successfully deleted'
    redirect_to admin_blog_posts_path
  end

  private

  def find_blog_post
    @post = BlogPost.friendly.find(params[:id])
  end

  def permit_params
    params.require(:blog_post).permit(BlogPost.strong_params)
  end

end
