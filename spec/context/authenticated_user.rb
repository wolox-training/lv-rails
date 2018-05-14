require 'rails_helper'

shared_context 'Authenticated User' do
  let(:user) { create(:user) }
  let!(:access_data) { User.generate_access_token(user) }
  let!(:access_token) { access_data[:token] }
  let!(:renew_id) { access_data[:renew_id] }

  before do
    request.headers['Authorization'] = access_token
  end
end
