class RecipesController < ApplicationController
  before_action :authenticate_user!

  def index
    @recipes = Recipe.where(public: true).or(Recipe.where(user: current_user))
  end

  def show
    @recipe = Recipe.find(params[:id])
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
    @recipe = Recipe.find(params[:id])
  end

  def toggle_public
    @recipe = Recipe.find(params[:id])
    @recipe.update(public: !@recipe.public)
    redirect_back fallback_location: recipes_path
  end

  def destroy
    @recipe = Recipe.find(params[:id])
    @recipe.destroy
    redirect_to recipes_url, notice: 'Recipe was successfully destroyed.'
  end
end
