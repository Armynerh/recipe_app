require 'rails_helper'

RSpec.describe Food, type: :model do
  let(:user) { User.create(name: 'test_user') }

  describe 'associations' do
    it { should belong_to(:user) }
    it { should have_many(:recipe_foods).dependent(:destroy) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:unit) }
    it { should validate_presence_of(:price) }
    it { should validate_presence_of(:quantity) }

    it { should validate_numericality_of(:price).only_integer }
    it { should validate_numericality_of(:quantity).only_integer }
  end

  describe 'instance methods' do
    it 'is valid with valid attributes' do
      food = Food.new(
        name: 'Example Food',
        unit: 'kg',
        price: 100,
        quantity: 2,
        user:
      )
      expect(food).to be_valid
    end

    it 'is not valid without a name' do
      food = Food.new(name: nil, unit: 'kg', price: 100, quantity: 2, user:)
      expect(food).to_not be_valid
    end
  end
end
