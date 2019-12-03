class FavoritesController < ApplicationController
  def index
    @favorites = Favorite.where(follower_id: current_user)
    @user_lists = List.where(user_id: current_user)
    unless current_user.nil?
      @reposts = current_user.reposts
    end
  end

  def create
    @user = User.find(params[:user_id])
    @favorite = Favorite.new(follower_id: current_user.id, followed_id: @user.id)
    if @favorite.save!
      redirect_to root_path
    else
      render new
    end
  end

  # def destroy
  #   @repost = Repost.find(params[:id])
  #   @repost.delete
  #   redirect_to user_reposts_path
  # end
end
