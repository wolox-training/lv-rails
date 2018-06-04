require 'rails_helper'

describe RentsController do
  let!(:rents) { create_list(:rent, 4) }

  describe 'GET #index' do
    context 'With an unauthenticated user' do
      it 'returns an unauthorized status' do
        get :index
        expect(response).to have_http_status(:unauthorized)
      end
    end

    context 'With an authenticated user' do
      include_context 'Authenticated User'

      it 'returns all rents' do
        get :index
        expect(JSON.parse(response.body)['total_count']).to eq(rents.size)
      end

      it 'returns a 200 ok status' do
        get :index, params: { rent: { user: rents.first.user } }
        expect(response).to have_http_status(:ok)
      end

      context 'With incorrect params' do
        it 'returns empty response' do
          date = Date.new(2017, 5, 28) # Rent factory shouldn't include 2017
          get :index, params: { rent: { from: date } }
          expect(JSON.parse(response.body)['total_count']).to eq(0)
        end
      end

      # Try to access to a record belonging to another user,
      #   that should return a :forbidden response
      # Try to access to a record belonging to the logged in user,
      #   that should return that record serialized.
    end
  end

  describe 'POST #create' do
    context 'With an unauthenticated user' do
      it 'returns an unauthorized status' do
        post :create, params: { rent: create(:rent) }
        expect(response).to have_http_status(:unauthorized)
      end
    end

    context 'With an authenticated user' do
      include_context 'Authenticated User'

      it 'returns a 201 ok status' do
        # 201: The request has been fulfilled and has resulted
        # in one or more new resources being created.
        r = create(:rent)
        post :create, params: { rent: { book_id: r.book, from: r.from, to: r.to } }
        expect(response).to have_http_status(:created)
      end

      it 'returns 2 jobs pendings' do
        r = create(:rent)
        post :create, params: { rent: { book_id: r.book, from: r.from, to: r.to } }
        expect(Sidekiq::Worker.jobs.size).to eq(2)
      end

      context 'missing foreign keys' do
        it 'missing user_id use current_user' do
          r = create(:rent)
          post :create, params: { rent: { user_id: nil, book_id: r.book, from: r.from, to: r.to } }
          expect(response).to have_http_status(:created)
        end

        it 'missing book_id not works' do
          r = create(:rent)
          post :create, params: { rent: { user_id: nil, book_id: nil, from: r.from, to: r.to } }
          expect(response).to have_http_status(:unprocessable_entity)
        end
      end
    end
  end
end
