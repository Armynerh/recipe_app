class RemovePublicFromRecipes < ActiveRecord::Migration[7.1]
  def change
    remove_column :recipes, :public, :boolean
  end
end
