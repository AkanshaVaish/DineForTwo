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

  def edit
    @restaurant = Restaurant.find(params[:id])
  end

  def create
    @restaurant = Restaurant.new(restaurant_params)

    if @restaurant.save
      flash[:info] = "Restaurant succesfully created."
      redirect_to @restaurant
    else
      render 'new'
    end
  end

  def update
    @restaurant = Restaurant.find(params[:id])
    if @restaurant.update(restaurant_params)
      redirect_to @restaurant
    else
      render 'edit'
    end
  end 


  #a favorite method which allows a user to mark a restaurant that they're intrested in
  def favorite
    type = params[:type]
    @restaurant = Restaurant.find(params[:id])
    if type == "favorite"

      current_user.favorites << @restaurant
      redirect_to :back, notice: 'You favorited the restaurant succesfully.'
    elsif type == "unfavorite"
      current_user.favorites.delete(@restaurant)
      redirect_to :back, notice: 'Unfavorited the restaurant succesfully.'
    else
      redirect_to :back, notice: 'Nothing happened'
    end
  end

  private
    def restaurant_params
      params.require(:restaurant).permit(:name)
    end

end
