class RelationshipsController < ApplicationController
  before_action :require_user_logged_in
  
  def create
    group = Group.find(params[:group_id])
    current_user.join(group)
    flash[:success] = 'グループに参加しました。'
    redirect_to groups_path
  end

  def destroy
    group = Group.find(params[:group_id])
    current_user.exit(group)
    flash[:success] = 'グループを退出しました。'
    redirect_to groups_path
  end
end
