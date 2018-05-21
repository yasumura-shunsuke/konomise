class FavoritesController < ApplicationController
  before_action :require_user_logged_in
  
  def create
    @group = Group.find(params[:group_id])
    @restaurant = Restaurant.find(params[:restaurant_id])
    current_user.like(@group, @restaurant)
    flash[:success] = 'お気に入り登録が完了しました'
    redirect_back(fallback_location: restaurant_search_group_path(id: params[:group_id]))
  end

  def destroy
    @group = Group.find(params[:group_id])
    @restaurant = Restaurant.find(params[:restaurant_id])
    current_user.unlike(@group, @restaurant)
    flash[:success] = 'お気に入り登録を解除しました'
    redirect_back(fallback_location: restaurant_search_group_path(id: params[:group_id]))
  end
end
