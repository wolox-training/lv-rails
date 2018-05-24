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

      it 'without params returns all rents' do
        get :index
        expect(JSON.parse(response.body)['total_count']).to eq(rents.size)
      end

      it 'returns a 200 ok status' do
        get :index, params: { rent: { user: rents.first.user } }
        expect(response).to have_http_status(:ok)
      end

      def unique_date
        date = Faker::Date.backward(50)
        date = Faker::Date.backward(50) while rents.map(&:from).include?(date)
        date
      end

      it 'incorrect params returns empty response' do
        get :index, params: { rent: { from: unique_date } }
        expect(JSON.parse(response.body)['total_count']).to eq(0)
      end
    end
  end

  describe 'POST #create' do
    context 'With an unauthenticated user' do
      it 'returns an unauthorized status' do
        post :create, params: { rent: create(:rent) }
        expect(response).to have_http_status(:unauthorized)
      end

      it 'With an unauthentucated user and incorrect params' do
        rent = create(:rent)
        rent.user = nil
        post :create, params: { rent: rent }
        expect(response).to have_http_status(:unauthorized)
      end
    end

    context 'With an authenticated user' do
      include_context 'Authenticated User'

      def rent_hash
        rent = create(:rent)
        Hash.new(
          user: rent.user,
          book: rent.book,
          from: rent.from,
          to: rent.to
        )
      end

      it 'returns a 201 ok status' do
        # 201: The request has been fulfilled and has resulted
        # in one or more new resources being created.
        post :create, params: { rent: rent_hash }
        expect(response).to have_http_status(:created)
      end

      it 'missing user foreign keys' do
        hash = rent_hash
        hash[user] = nil
        expect { post :create, params: { rent: hash } }.to \
          raise_error ActiveModel::ForbiddenAttributesError
      end
    end
  end
end
