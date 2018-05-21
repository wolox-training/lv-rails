require 'rails_helper'

describe BookController do
  let!(:books) { create_list(:book, 3) }

  describe 'GET #index' do
    context 'With an unauthenticated user' do
      it 'returns an unauthorized status' do
        get :index, params: {}
        expect(response).to have_http_status(:unauthorized)
      end
    end

    context 'With an authenticated user' do
      include_context 'Authenticated User'

      it 'without params returns all books' do
        get :index
        expect(JSON.parse(response.body)['total_count']).to eq(books.size)
      end

      it 'returns a 200 ok status' do
        get :index, params: { book: { genre: books.first.genre } }
        expect(response).to have_http_status(:ok)
      end

      def unique_title
        rnd_title = Faker::Book.title
        rnd_title = Faker::Book.title while books.map(&:title).include?(rnd_title)
        rnd_title
      end

      it 'params filters not exists' do
        get :index, params: { book: { title: unique_title } }
        expect(JSON.parse(response.body)['total_count']).to eq(0)
      end

      def full_index_response
        b = books.first
        get :index, params: { book: {
          title: b.title,
          # Below are additional params
          image: b.image,
          publisher: b.publisher,
          year: b.year
        } }
      end

      it 'setting additionals params' do
        full_index_response
        expect(response).to have_http_status(:ok)
        # it response status ok becouse additionals params are not used
      end
    end
  end

  describe 'GET #show' do
    context 'With an unauthenticated user' do
      it 'returns an unauthorized status' do
        get :show, params: {}
        expect(response).to have_http_status(:unauthorized)
      end
    end

    context 'With an authenticated user' do
      include_context 'Authenticated User'

      it 'responds with 200 status' do
        get :show, params: { book: { id: books.first.id } }
        expect(response).to have_http_status(:ok)
      end

      def unique_id
        rnd_id = Faker::Number.number(10)
        rnd_id = Faker::Number.number(10) while books.map(&:id).include?(rnd_id)
        rnd_id
      end

      it 'With an incorrect id' do
        expect { get :show, params: { book: { id: unique_id } } }.to raise_error ActiveRecord::RecordNotFound
      end
    end
  end
end