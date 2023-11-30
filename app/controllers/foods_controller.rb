class FoodsController < ApplicationController
    before_action :authenticate_user!

    def index
      @foods = current_user.foods
      @new_food = Food.new
    end

    def show; end

    def new
      @food = Food.new
    end

    def create
      @food = Food.new(food_params)
      @food.user = current_user
  
      if @food.save
        redirect_to foods_path, notice: 'Food was successfully created.'
      else
        render :new
      end
    end

    def edit; end

    def destroy
      @food = current_user.foods.find(params[:id])
      @food.destroy
      redirect_to foods_path, notice: 'Food was successfully destroyed.'
    end

    private

    def food_params
      params.require(:food).permit(:name, :unit, :price, :quantity)
    end
end

