class RecipeFoodsController < ApplicationController
  # app/controllers/recipe_foods_controller.rb
  class RecipeFoodsController < ApplicationController
    before_action :authenticate_user!
    before_action :set_recipe

    def new
      @recipe_food = @recipe.recipe_foods.build
    end

    def create
      @recipe_food = @recipe.recipe_foods.build(recipe_food_params)

      if @recipe_food.save
        redirect_to @recipe, notice: 'Ingredient was successfully added.'
      else
        render :new
      end
    end

    def edit
      @recipe_food = RecipeFood.find(params[:id])
    end

    def update
      @recipe_food = RecipeFood.find(params[:id])

      if @recipe_food.update(recipe_food_params)
        redirect_to @recipe, notice: 'Ingredient was successfully updated.'
      else
        render :edit
      end
    end

    def destroy
      @recipe_food = RecipeFood.find(params[:id])
      @recipe_food.destroy
      redirect_to @recipe, notice: 'Ingredient was successfully removed.'
    end

    private

    def set_recipe
      @recipe = Recipe.find(params[:recipe_id])
    end

    def recipe_food_params
      params.require(:recipe_food).permit(:food_id, :quantity)
    end
  end
end
