class UsersController < ApplicationController
  before_action :require_user_logged_in, only: [:index, :show]
  
  def index
  end

  def show
  end

  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)

    if @user.save
      session[:user_id] = @user.id
      flash[:success] = 'ユーザー登録が完了しました。'
      redirect_to controller: :toppages, action: :index, id: @user.id
    else
      flash.now[:danger] = 'ユーザの登録に失敗しました。'
      render :new
    end
  end

 private
  
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

end
