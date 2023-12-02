require 'rails_helper'

RSpec.describe 'Foods', type: :feature do
  before do
    user = FactoryBot.create(:user)
    login_as(user, scope: :user)
    @food1 = FactoryBot.create(:food, name: 'apple', unit: 'unit', price: 5, quantity: 3, user:)
    @food2 = FactoryBot.create(:food, name: 'beans', unit: 'kg', price: 9, quantity: 5, user:)
  end

  describe 'index page' do
    it 'renders the Foods page' do
      visit foods_path
      sleep 1

      expect(page).to have_content(@food1.name)
      expect(page).to have_content(@food2.name)
      expect(page).to have_content(@food1.unit)
      expect(page).to have_content(@food2.unit)
      expect(page).to have_content(@food1.price)
      expect(page).to have_content(@food2.price)
    end
  end
end
