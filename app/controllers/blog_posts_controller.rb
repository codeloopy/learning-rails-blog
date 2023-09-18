class BlogPostsController < ApplicationController
  before_action :find_blog_post, except: [ :index, :new, :create ]
  before_action :authenticate_user!, except: [ :index, :show ]
  
  def index
    # @blog_posts = BlogPost.all
    @blog_posts = current_user ? BlogPost.sorted : BlogPost.published.sorted
  end

  def new
    @blog_post = BlogPost.new
  end

  def create
    @blog_post = BlogPost.new(blog_post_params)
    
    if @blog_post.save
      redirect_to @blog_post
    else
      render :new, status: :unprocessable_entity
    end
  end
  
  def edit
  end
  
  def update
    if @blog_post.update(blog_post_params)
      redirect_to @blog_post
    else
      render :edit, status: :unprocessable_entity
    end
  end
  
  def show
  end

  def destroy
    @blog_post.destroy
    redirect_to :root
  end
  
  private
    def find_blog_post
      @blog_post = current_user ? BlogPost.find(params[:id]) : BlogPost.published.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      redirect_to root_path
    end

    def blog_post_params
      params.require(:blog_post).permit(:title, :body, :published_at)
    end
end