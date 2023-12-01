class Recipe < ApplicationRecord
  belongs_to :user
  has_many :recipe_foods, dependent: :destroy
  has_many :foods, through: :recipe_foods # Correct the association name to plural (foods)

  validates :name, presence: true
  validates :preparation_time, presence: true, numericality: { only_integer: true }
  validates :cooking_time, presence: true, numericality: { only_integer: true }
  validates :description, presence: true
  validates :user_id, presence: true
  validates :public, inclusion: { in: [true, false] }

  def total_price
    foods.sum(:price)
  end

  def total_food_items
    recipe_foods.count
  end
end
