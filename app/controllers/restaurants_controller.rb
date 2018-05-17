class RestaurantsController < ApplicationController
  def index
    @restaurants = Restaurant.all
  end

  def show
    @restaurant = Restaurant.find(params[:id])
  end

  def new
    @restaurant = Restaurant.new
  end

  def create
    @restaurant = Restaurant.new(restaurant_params)
    if @restaurant.save
      flash[:success] = 'レストラン登録が完了しました'
      redirect_to action: :index
    else
      flash.now[:danger] = 'レストラン登録に失敗しました'
      render :new
    end
  end
  
  private
  
  def restaurant_params
    params.require(:restaurant).permit(:name, :address, :area, :station, :phone_number)
  end
  
end
