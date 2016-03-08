class CommentsController < ApplicationController
before_action :authenticate_user!

  def create
    comment_params = params.require(:comment).permit(:body)
    @post = Post.find params[:post_id]
    @comment = Comment.new comment_params
    @comment.post = @post
    if @comment.save
      redirect_to post_path(@post), notice: 'Comment created.'
    else
      flash[:alert] = 'Comment is not unique.'
      render '/posts/show'
    end
  end

  def destroy
    @post = Post.find params[:post_id]
    @comment = Comment.find params[:id]
    @comment.destroy
    redirect_to post_path(@post), notice: 'Comment deleted.'
  end

end
