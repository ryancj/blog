class PostsController < ApplicationController
before_action :find_post, only: [:show, :edit, :update, :destroy]
# before_action :authenticate_user!, except: [:show, :index]

  def new
    redirect_to root_path, alert: "Access denied." and return unless can? :create, Post
    @post = Post.new
  end

  def create
    @post = Post.new post_params
    if @post.save
      redirect_to post_path(@post), notice: 'Post created.'
    else
      flash[:alert] = 'Check errors and try again.'
      render :new
    end
  end

  def show
    @comment = Comment.new
  end

  def index
    @posts = Post.all

    if params[:search]
      @posts = Post.search(params[:search]).order('created_at DESC').page(params[:page])
    else
      @posts = Post.all.order('created_at DESC').page(params[:page])
    end
  end

  def edit
    redirect_to root_path, alert: "Access denied." unless can? :edit, @post
  end

  def update
    @post.update post_params
    if @post.save
      redirect_to post_path(@post), notice: 'Post updated.'
    else
      flash[:alert] = 'Check errors and try again.'
      render :edit
    end
  end

  def destroy
    @post.destroy
    redirect_to posts_path, notice: 'Post deleted.'
  end

  private

    def post_params
      params.require(:post).permit(:title, :body, :category_id)
    end

    def find_post
      @post = Post.find params[:id]
    end
end
