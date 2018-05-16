require 'rails_helper'

describe RentController do

  describe 'GET #index' do

    def index_requiere
      r = rents.first
      get :index, params: { rent: {
        user: r.user,
        book: r.book,
        from: r.from,
        to:   r.to
      } }
    end

    context 'With an unauthenticated user' do
      it 'returns an unauthorized status' do
        index_requiere
        expect(response).to have_http_status(:unauthorized)
      end
    end

    context 'With an authenticated user' do
      include_context 'Authenticated User'
      let!(:rents) { create_list(:book, 3, user: user) }

      it 'without params' do
        expect { get :index }.to raise_error ActionController::ParameterMissing
      end

      it 'with an empty rent param' do
        expect { get :index, params: { rent: {} } }.to raise_error ActionController::ParameterMissing
      end

      it 'returns a 200 ok status' do
        index_requiere
        expect(response).to have_http_status(:ok)
      end
    end
  end

  describe 'GET #create' do
    it 'returns http success' do
      post :create, params: { rent: rents.first }
      expect(response).to have_http_status(:success)
    end
  end
end
