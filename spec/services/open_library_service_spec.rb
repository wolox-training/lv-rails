require 'rails_helper'

describe OpenLibraryService do
  response_path = './spec/fixtures/stubs_and_mocks/open_library_service_response_body.txt'

  before do
    stub_request(:any, %r{.*\/api\/books\?bibkeys=ISBN:.*&format=json&jscmd=data}) \
      .to_return(body: File.open(response_path))
  end

  describe '#book_info' do
    context 'With existent isbn' do
      existent_isbn = '0385472579'
      it 'returns book hash data' do
        o = described_class.new
        hash = o.book_info(existent_isbn)
        expected_hash = { isbn: existent_isbn, title: 'Zen speaks', number_of_pages: 159, \
                          subtitle: 'shouts of nothingness', authors: ['Zhizhong Cai'] }
        expect(hash).to eq expected_hash
      end
    end

    context 'With invalid isbn' do
      invalid_isbn = '3854725221'
      it 'raise argumentError' do
        o = described_class.new
        expect { o.book_info(invalid_isbn) }.to raise_error(ArgumentError)
      end
    end
  end
end
