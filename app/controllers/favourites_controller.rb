class FavouritesController < ApplicationController
before_action :authenticate_user!

  def create
    fav = current_user.favourites.new
    post = Post.find params[:post_id]
    fav.post = post

    if fav.save
      redirect_to post, notice: 'Favourited.'
    else
      redirect_to post, alert: "Can't be Favourited."
    end
  end

  def destroy
    fav = current_user.favourites.find params[:id]
    post = Post.find params[:post_id]
    fav.post = post

    fav.destroy
    redirect_to post, notice: 'Unfavourited.'
  end

end
