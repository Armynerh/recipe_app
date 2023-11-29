class Food < ApplicationRecord
  belongs_to :user
  has_many :recipe_foods, dependent: :destroy

  validates :name, :unit, :price, :quantity, presence: true
  validates :price, :quantity, numericality: { only_integer: true }
end
