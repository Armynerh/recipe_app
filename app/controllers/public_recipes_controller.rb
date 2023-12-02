class PublicRecipesController < ApplicationController
  def index
    @public_recipes = Recipe.where(public: true).includes(:user, :recipe_foods, :foods).order(created_at: :desc)
  end

  def show; end

  def destroy
    @recipe = Recipe.find(params[:id])
    @recipe.destroy if current_user == @recipe.user
    redirect_to public_recipes_path, notice: 'Recipe was successfully deleted.'
  end
end
