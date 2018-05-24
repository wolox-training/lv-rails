require 'rails_helper'

describe BooksController do
  let!(:books) { create_list(:book, 3) }

  describe 'GET #index' do
    context 'with an unauthenticated user' do
      it 'returns an unauthorized status' do
        get :index, params: {}
        expect(response).to have_http_status(:unauthorized)
      end
    end

    context 'with an authenticated user' do
      include_context 'Authenticated User'

      context 'with a correct param' do
        it 'returns a 200 ok status' do
          get :index, params: { book: { genre: books.first.genre } }
          expect(response).to have_http_status(:ok)
        end

        it 'returns the correct filtered collection' do
          b = books.first
          get :index, params: { book: { title: b.title, image: b.image, publisher: b.publisher, year: b.year } } # rubocop:disable Metrics/LineLength
          expect(JSON.parse(response.body)['page'].first['title']).to eq(b.title)
        end
      end

      context 'without params' do
        it 'returns all books' do
          get :index
          expect(JSON.parse(response.body)['total_count']).to eq(books.size)
        end
      end

      context 'with inexistent filters' do
        it 'returns empty response' do
          get :index, params: { book: { title: 'HY43Ewcqw!$ds1' } }
          expect(JSON.parse(response.body)['total_count']).to eq(0)
        end
      end
    end
  end

  describe 'GET #show' do
    context 'With an unauthenticated user' do
      it 'returns an unauthorized status' do
        get :show, params: { id: books.first.id }
        expect(response).to have_http_status(:unauthorized)
      end
    end

    context 'With an authenticated user' do
      include_context 'Authenticated User'

      it 'responds with 200 status' do
        get :show, params: { id: books.first.id }
        expect(response).to have_http_status(:ok)
      end

      context 'With an incorrect id' do
        it 'responds with 404 status' do
          get :show, params: { id: '-1' }
          expect(response).to have_http_status(:not_found)
        end
      end
    end
  end
end
