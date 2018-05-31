require 'rails_helper'

describe OpenLibraryService do
  response_path = './spec/fixtures/stubs_and_mocks/open_library_service_response_body.txt'

  describe '#book_info' do
    context 'With a correct isbn' do
      existent_isbn = '0385472579'
      it 'returns book hash data' do
        stub_request(:any, %r{.*\/api\/books\?bibkeys=ISBN:.*&format=json&jscmd=data}) \
          .to_return(body: File.open(response_path))

        o = described_class.new
        hash = o.book_info(existent_isbn)
        expect(hash[:title]).to eq 'Zen speaks'
      end
    end
  end
end
