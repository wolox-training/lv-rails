require 'rails_helper'

describe 'User' do
  subject(:user) { create(:user) }

  context 'User#create with Factory and Faker' do
    it 'Generates a random verification code' do
      user.save!
      expect(user.id).to be_present
    end
  end
end
