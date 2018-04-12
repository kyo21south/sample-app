class FavoritesController < ApplicationController
  before_action :logged_in_user
  
  def create
    @micropost = Micropost.find(params[:micropost_id])
    @current_user = current_user
    # @path = request.path_info
    current_user.fav(@micropost)
    respond_to do |format|
      format.html { redirect_to root_path }
      format.js
    end
  end

  def destroy
    @micropost = Favorite.find(params[:id]).micropost
    @current_user = current_user
    # @path = request.path_info
    current_user.unfav(@micropost)
    respond_to do |format|
      format.html { redirect_to root_path }
      format.js
    end
  end
end
