require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'associations' do
    it { should have_many(:foods).dependent(:destroy) }
    it { should have_many(:recipes).dependent(:destroy) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:password) }
  end

  describe 'Devise modules' do
    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:password) }

    it { should have_many(:foods).dependent(:destroy) }
    it { should have_many(:recipes).dependent(:destroy) }

    it { should validate_uniqueness_of(:email).case_insensitive }
    it { should validate_length_of(:password).is_at_least(6).is_at_most(128) }
  end
end
