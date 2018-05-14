require 'rails_helper'
require './spec/context/authenticated_user.rb'

describe 'BooksController' do

  describe 'GET #index' do
    include_context 'Authenticated User'

    context 'When fetching all the books' do
      let!(:books) { create_list(:book, 3, user: user) }

      it 'Listing books' do
        books.each do |book|
            byebug
            print (book.title)
        end
      end

      before do
        get :index, params: { id: book.id }
      end

      it 'responses with the books json' do
        expected = ActiveModel::Serializer::CollectionSerializer.new(
          books, each_serializer: BookSerializer
        ).to_json
        expect(response_body.to_json) =~ JSON.parse(expected)
      end

      it 'responds with 200 status' do
        expect(response).to have_http_status(:ok)
      end
    end
  end
end
#   describe 'GET #show' do
#     context 'When fetching a book' do
#       let!(:book) { create(:book, user: user) }

#       before do
#         get :show, params: { user_id: user.id, id: rent.id }
#       end

#       it 'responses with the user rent json' do
#         expect(response_body.to_json).to eq RentSerializer.new(
#           rent, root: false
#         ).to_json
#       end

#       it 'responds with 200 status' do
#         expect(response).to have_http_status(:ok)
#       end
#     end
#   end
