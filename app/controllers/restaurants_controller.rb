class RestaurantsController < ApplicationController
  def index
    @restaurants = Restaurant.all
    @locations = Location.all
  end

  def show
    @restaurant = Restaurant.find(params[:id])
  end

  def new
    @restaurant = Restaurant.new
    @locations = Location.all.map{|l| [l.name, l.id]}
  end

  def edit
    @restaurant = Restaurant.find(params[:id])
    @locations = Location.all.map{|l| [l.name, l.id]}
  end

  def create
    @restaurant = Restaurant.new(restaurant_params)
    @restaurant.location_id = params[:location_id]
      if @restaurant.save
        flash[:info] = "Restaurant succesfully created."
        redirect_to @restaurant
      else
        render 'new'
      end
  end
  #   if @restaurant.save
  #     flash[:info] = "Restaurant succesfully created."
  #     redirect_to @restaurant
  #   else
  #     render 'new'
  #   end
  # end

  def update
    @restaurant = Restaurant.find(params[:id])
    @restaurant.location_id = params[:location_id]
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

  def destroy
    Restaurant.find(params[:id]).destroy
    flash[:success] = "Restaurant deleted."
    redirect_to restaurants_url
  end

  private
    def restaurant_params
      params.require(:restaurant).permit(:name, :avatar)
    end

end
