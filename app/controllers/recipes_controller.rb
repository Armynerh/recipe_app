class RecipesController < ApplicationController
  before_action :authenticate_user!

  def index
    @recipes = current_user.recipes
  end

  def show
    @recipe = Recipe.includes(recipe_foods: :food).find(params[:id])
    redirect_to recipes_path unless @recipe.public || (user_signed_in? && current_user == @recipe.user)
  end

  def new
    @recipe = Recipe.new
  end

  def create
    @recipe = current_user.recipes.build(recipe_params)

    if @recipe.save
      redirect_to @recipe, notice: 'Recipe was successfully created.'
    else
      render :new
    end
  end

  def edit
    @recipe = Recipe.includes(recipe_foods: :food).find(params[:id])
  end

  def toggle_public
    @recipe = Recipe.find(params[:id])
    if current_user == @recipe.user
      @recipe.update(public: !@recipe.public)
      redirect_back fallback_location: recipes_path
    else
      redirect_back fallback_location: recipes_path, alert: 'You are not authorized to toggle the visibility of this recipe.'
    end
  end

  def destroy
    @recipe = Recipe.find(params[:id])
    if current_user == @recipe.user
      @recipe.destroy
      redirect_to recipes_url, notice: 'Recipe was successfully destroyed.'
    else
      redirect_to recipes_url, alert: 'You are not authorized to destroy this recipe.'
    end
  end
end
