require 'rails_helper'

RSpec.describe Recipe, type: :model do
  let(:user) { create(:user) }

  describe 'associations' do
    it { should belong_to(:user) }
    it { should have_many(:recipe_foods).dependent(:destroy) }
    it { should have_many(:foods).through(:recipe_foods) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:preparation_time) }
    it { should validate_numericality_of(:preparation_time).only_integer }
    it { should validate_presence_of(:cooking_time) }
    it { should validate_numericality_of(:cooking_time).only_integer }
    it { should validate_presence_of(:description) }
    it { should validate_presence_of(:user_id) }
    it { should validate_inclusion_of(:public).in_array([true, false]) }
  end

  describe 'methods' do
    let(:recipe) { create(:recipe, user:) }
    let(:food1) { create(:food, price: 10, user:, unit: 'kg') }
    let(:food2) { create(:food, price: 15, user:, unit: 'g') }

    before do
      create(:recipe_food, recipe:, food: food1)
      create(:recipe_food, recipe:, food: food2)
    end

    describe '#total_price' do
      it 'calculates the total price of the recipe' do
        expect(recipe.total_price).to eq(25)
      end
    end

    describe '#total_food_items' do
      it 'counts the total number of food items in the recipe' do
        expect(recipe.total_food_items).to eq(2)
      end
    end
  end
end
