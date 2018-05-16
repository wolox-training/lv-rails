require 'rails_helper'

describe RentController do
  describe 'POST #create' do
    context 'With an unauthenticated user' do
      it 'returns an unauthorized status' do
        post :create, params: {}
        expect(response).to have_http_status(:unauthorized)
      end
    end

    context 'With an authenticated user' do
      include_context 'Authenticated User'

      it 'returns a 201 ok status' do
        # 201: The request has been fulfilled and has resulted 
        # in one or more new resources being created.
        post :create, params: { rent: create(:rent) }
        expect(response).to have_http_status(:created)
      end
    end
  end

  describe 'GET #index' do
    context 'With an unauthenticated user' do
      it 'returns an unauthorized status' do
        get :index, params: {}
        expect(response).to have_http_status(:unauthorized)
      end
    end

    context 'With an authenticated user' do
      include_context 'Authenticated User'

      it 'without params' do
        expect { get :index }.to raise_error ActionController::ParameterMissing
      end

      it 'with an empty rent param' do
        expect { get :index, params: { rent: {} } }.to raise_error ActionController::ParameterMissing
      end

      def index_requiere
        r = create(:rent)
        get :index, params: { rent: {
          user: r.user,
          book: r.book,
          from: r.from,
          to:   r.to
        } }
      end

      it 'returns a 200 ok status' do
        index_requiere
        expect(response).to have_http_status(:ok)
      end
    end
  end
end
