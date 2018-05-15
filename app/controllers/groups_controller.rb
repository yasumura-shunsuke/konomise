class GroupsController < ApplicationController
  before_action :require_user_logged_in
  
  def index
    @groups = Group.all
    @count_groups = @groups.count
  end

  def show
  end

  def new
    @group = Group.new
    @user  = current_user.name
  end

  def create
    @group = current_user.groups.build(group_params)
    if @group.save
      flash[:success] = 'グループ登録が完了しました'
      redirect_to action: :index
    else
      flash.now[:danger] = 'グループ登録に失敗しました'
      render :new
    end
  end

  def edit
  end

  def update
  end

  def destroy
    @group.destroy
    flash[:success] = 'グループを削除しました。'
    redirect_back(fallback_location: :index)
  end
  
  private
  
  def group_params
    params.require(:group).permit(:title, :user_id, :sentence)
  end
  
  def correct_user
    @group = current_user.groups.find_by(id: params[:id])
    unless @group
      redirect_to root_url
    end
  end
  
end
