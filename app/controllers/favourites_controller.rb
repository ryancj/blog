class FavouritesController < ApplicationController
before_action :authenticate_user!

  def index
  end

  def createz
    @post = Post.find params[:post_id]
    fav = Favourite.new(post: @post, user: current_user)
    respond_to do |format|
      if fav.save
        format.html  { redirect_to @post, notice: 'Favourited.' }
        format.js    { render :fav_success }
      else
        format.html  { redirect_to @post, alert: "Can't be Favourited." }
        format.js    { render :fav_failure }
      end
    end
  end

  def destroy
    fav = current_user.favourites.find params[:id]
    @post = Post.find params[:post_id]
    fav.destroy
    respond_to do |format|
      format.html { redirect_to post_path(@post), notice: 'Unfavourited.' }
      format.js   { render }
    end
  end

end
