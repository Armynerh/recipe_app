class Recipe < ApplicationRecord
  belongs_to :user
  has_many :recipe_food, dependent: :destroy
  has_many :food, through: :recipe_food

  validates :name, presence: true
  validates :preparation_time, presence: true, numericality: { only_integer: true }
  validates :cooking_time, presence: true, numericality: { only_integer: true }
  validates :description, presence: true
  validates :user_id, presence: true
  validates :public, inclusion: { in: [true, false] }

  def recipe_food_counts
    recipe_count = recipe_food.count
    price_sum = food.sum(:price)
    { recipe_count:, price_sum: }
  end
end
