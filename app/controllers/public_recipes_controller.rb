class PublicRecipesController < ApplicationController
  def index
    @public_recipes = Recipe.where(public: true).includes(:user, :recipe_foods, :foods).order(created_at: :desc)
  end

  def show; end

  def destroy
    @recipe = Recipe.find(params[:id])
    if current_user == @recipe.user
      @recipe.destroy
      redirect_to public_recipes_path, notice: 'Recipe was successfully deleted.'
    else
      redirect_to public_recipes_path, alert: 'You are not authorized to delete this recipe.'
    end
  end
end
