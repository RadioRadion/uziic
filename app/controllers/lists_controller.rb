class ListsController < ApplicationController
  skip_before_action :authenticate_user!, :only => [:index]
  def index
    if params[:query].present? || params[:query_town].present?
      sql_query = " \
      lists.name ILIKE :query \
      OR lists.tags ILIKE :query \
      "
      sql_query_town = "\
      users.address ILIKE :query_town \
      "
      @lists = List.where(sql_query, query: "%#{params[:query]}%").joins(:user).where(sql_query_town, query_town: "%#{params[:query_town]}%")
    else
      @lists = List.all
    end
    @list = List.new
  end

  def create
    @lists = current_user.lists
    @list = List.new(list_params)
    @list.user = current_user
    if @list.save
      redirect_to lists_path(@list)
    else
      render 'lists/index'
    end
  end

  def edit
    @list = List.find(params[:id])
  end

  def update
    @list = List.find(params[:id])
    @list.update(list_params)
    redirect_to lists_path(@list)
  end

  def destroy
    @list = List.find(params[:id])
    @list.destroy
    redirect_to lists_path
  end

  private

  def list_params
    params.require(:list).permit(:name, :tags)
  end
end
