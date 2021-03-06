class SongsController < ApplicationController
  skip_before_action :authenticate_user!, :only => [:index]
  def index
    if params[:query].present? || params[:query_town].present?
      sql_query = " \
      songs.title ILIKE :query \
      OR songs.tags ILIKE :query \
      OR songs.description ILIKE :query \
      "
      sql_query_town = "\
      users.address ILIKE :query_town \
      "
      @songs = Song.where(sql_query, query: "%#{params[:query]}%").joins(:user).where(sql_query_town, query_town: "%#{params[:query_town]}%").order(created_at: :desc)
    else
      @songs = Song.all.order(created_at: :desc)
    end
    @user_lists = List.where(user_id: current_user)
    unless current_user.nil?
      @reposts = current_user.reposts
    end
  end
end
