require 'rails_helper'

describe BookController do
  let!(:books) { create_list(:book, 3) }

  describe 'GET #index' do
    context 'Unusual params' do
      it 'without params' do
        expect { get :index }.to raise_error ActionController::ParameterMissing
      end

      it 'with an empty book param' do
        expect { get :index, params: { book: {} } }.to raise_error ActionController::ParameterMissing
      end

      it 'adding additional params' do
        b = books.first
        get :index, params: { book: {
          genre: b.genre,
          title: b.title,
          author: b.author,
          # Below are additional params
          image: b.image,
          publisher: b.publisher,
          year: b.year
        } }
        expect(response).to have_http_status(:ok)
      end
    end

    before do
      b = books.first
      get :index, params: { book: {
        genre: b.genre,
        title: b.title,
        author: b.author
      } }
    end

    context 'With an authenticated user' do
      include_context 'Authenticated User'

      it 'returns a 200 ok status' do
        expect(response).to have_http_status(:ok)
      end
    end

    context 'With an unauthenticated user' do
      it 'returns an unauthorized status' do
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end

  describe 'GET #show' do
    it 'Without params' do
      expect { get :show }.to raise_error ActionController::ParameterMissing
    end

    before do
      get :show, params: { book: { id: books.first.id } }
    end

    it 'responds with 200 status' do
      expect(response).to have_http_status(:ok)
    end
  end
end
