class CommentsController < ApplicationController
before_action :authenticate_user!

  def create
    comment_params = params.require(:comment).permit(:body)
    @post = Post.find params[:post_id]
    @comment = Comment.new comment_params
    @comment.post = @post
    @comment.user = current_user
    redirect_to post_path(@post),
    alert: "You must be signed-in before you can make a comment" and return unless can? :create, @comment
    if @comment.save
      CommentsMailer.notify_post_owner(@comment).deliver_later if user_signed_in?
      redirect_to post_path(@post), notice: 'Comment created.'
    else
      flash[:alert] = 'Comments should be unique.'
      render '/posts/show'
    end
  end

  def destroy
    @post = Post.find params[:post_id]
    @comment = Comment.find params[:id]
    redirect_to root_path, alert: "You cannot delete this comment." and return unless can? :destroy, @comment
    @comment.destroy
    redirect_to post_path(@post), notice: 'Comment deleted.'
  end

end
