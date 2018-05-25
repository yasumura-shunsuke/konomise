class GroupsController < ApplicationController
  before_action :require_user_logged_in
  
  def index
    @groups = Group.all.order('updated_at DESC')
    @count_groups = @groups.count
    @user = current_user
  end

  def show
    @group = Group.find(params[:id])
    @members = @group.group_users
    @post = @group.posts.build
    @created_posts = @group.posts.order('created_at DESC').page(params[:page]).per(5)
    @like_reataurants = @group.favorites.page(params[:page]).per(5)
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
    @group = Group.find(params[:id])
    render :new
  end

  def update
    @group = Group.find(params[:id])
    if @group.update(group_params)
      flash[:success] = 'グループ登録情報を更新しました'
      redirect_to action: :index
    else
      flash.now[:danger] = 'グループ登録情報を更新できませんでした'
      render :new
    end
    
  end

  def destroy
    @group = Group.find(params[:id])
    @group.destroy
    flash[:success] = 'グループを削除しました。'
    redirect_to action: :index
  end
  
  def restaurant_search
    # Parameters: {"utf8"=>"✓", "restaurant_area"=>"目黒", "search"=>"焼き", "id"=>"13"}
    # search_params{"restaurant_area"=>"目黒", "search"=>"焼き"}
    @restaurants = Restaurant.all
    name = params[:search]
    area = params[:restaurant_area]
    @restaurants = @restaurants.where(area: area) if area.present?
    @restaurants = @restaurants.where("name like '%" + name + "%'") if name.present?
    @count_restaurants = @restaurants.count
    @group = Group.find(params[:id])
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
