# spec/requests/foods_spec.rb

require 'rails_helper'

RSpec.describe FoodsController, type: :request do
  describe 'GET #index' do
    it 'renders the index template' do
      user = create(:user) 
      sign_in user

      get foods_path

      expect(response).to render_template(:index)
    end

    it 'assigns @foods and @new_food' do
      user = create(:user)
      sign_in user

      get foods_path

      expect(assigns(:foods)).to eq(user.foods.includes(:recipe_foods))
      expect(assigns(:new_food)).to be_a_new(Food)
    end
  end
end
