class PostsController < ApplicationController
  def index
    @posts = Post.all
  end

  def new
    if current_user.admin
      @post = Post.new
    else
      redirect_to root_path
      flash.alert = "Access denied!"
    end
  end

  def create
    @post = current_user.posts.build post_params
    if @post.save
      redirect_to @post
    else
      render :new
    end
  end

  def show
    @post = Post.find params[:id]
  end

  def edit
    @post = Post.find params[:id]
  end

  def update
    @post = Post.find params[:id]
    if @post.update post_params
      redirect_to @post
    else
      render :edit
    end
  end

  def destroy
    if current_user.admin
      @post = Post.find params[:id]
      @post.destroy
    else
      redirect_to root_path
      flash.notice = "Access denied!"
    end
  end

  private
    def post_params
      params.require(:post).permit(:title, :body)
    end
end
