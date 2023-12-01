class GeneralShoppingListsController < ApplicationController
  MissingFood = Struct.new(:food, :quantity)

  def index
    @user = current_user
    @missing_foods = calculate_missing_foods(@user)
    @total_food_items = @missing_foods.sum(&:quantity)
    @total_price = @missing_foods.sum { |food| food.quantity * food.food.price }
  end

  private

  def calculate_missing_foods(user)
    user_recipes = Recipe.where(user: user)
    user_food_ids = user.foods.pluck(:id)
    recipe_food_ids = RecipeFood.where(recipe: user_recipes).pluck(:food_id)
    missing_food_ids = (recipe_food_ids - user_food_ids).uniq
    missing_foods = Food.where(id: missing_food_ids).includes(:recipes)

    missing_foods.map do |food|
      MissingFood.new(
        food,
        user_recipes.sum { |recipe| recipe.recipe_foods.find_by(food: food)&.quantity.to_i }
      )
    end
  end
end
