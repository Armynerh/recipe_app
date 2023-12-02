# spec/requests/general_shopping_lists_spec.rb

require 'rails_helper'

RSpec.describe GeneralShoppingListsController, type: :request do
  describe 'GET #index' do
    let(:user) { create(:user) }

    context 'when user is authenticated' do
      before do
       
        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
      end

      it 'calculates missing foods and renders the index template' do
        allow_any_instance_of(GeneralShoppingListsController)
          .to receive(:calculate_missing_foods).with(user).and_return([])

        get '/general_shopping_lists' 

        expect(response).to render_template(:index)
        
      end
    end
  end
end
