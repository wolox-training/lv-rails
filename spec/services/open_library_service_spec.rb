require 'rails_helper'

describe OpenLibraryService do
  response_path = './spec/fixtures/stubs_and_mocks/open_library_service_response_body.txt'

  describe '#book_info' do
    context 'With existent isbn' do
      existent_isbn = '0385472579'

      it 'returns book isbn' do
        stub_request(:any, %r{.*\/api\/books\?bibkeys=ISBN:.*&format=json&jscmd=data}) \
          .to_return(body: File.open(response_path))
        o = described_class.new
        hash = o.book_info(existent_isbn)
        expect(hash[:isbn]).to eq existent_isbn
      end

      it 'returns book title' do
        stub_request(:any, %r{.*\/api\/books\?bibkeys=ISBN:.*&format=json&jscmd=data}) \
          .to_return(body: File.open(response_path))
        o = described_class.new
        hash = o.book_info(existent_isbn)
        expect(hash[:title]).to eq 'Zen speaks'
      end

      it 'returns book subtitle' do
        stub_request(:any, %r{.*\/api\/books\?bibkeys=ISBN:.*&format=json&jscmd=data}) \
          .to_return(body: File.open(response_path))
        o = described_class.new
        hash = o.book_info(existent_isbn)
        expect(hash[:subtitle]).to eq 'shouts of nothingness'
      end

      it 'returns book number of pages' do
        stub_request(:any, %r{.*\/api\/books\?bibkeys=ISBN:.*&format=json&jscmd=data}) \
          .to_return(body: File.open(response_path))
        o = described_class.new
        hash = o.book_info(existent_isbn)
        expect(hash[:number_of_pages]).to eq 159
      end

      it 'returns book authors' do
        stub_request(:any, %r{.*\/api\/books\?bibkeys=ISBN:.*&format=json&jscmd=data}) \
          .to_return(body: File.open(response_path))
        o = described_class.new
        hash = o.book_info(existent_isbn)
        expect(hash[:authors]).to eq ['Zhizhong Cai']
      end
    end

    context 'With invalid isbn' do
      invalid_isbn = '3854725221'
      it 'raise argumentError' do
        stub_request(:any, %r{.*\/api\/books\?bibkeys=ISBN:.*&format=json&jscmd=data}) \
          .to_return(body: File.open(response_path))
        o = described_class.new
        expect { o.book_info(invalid_isbn) }.to raise_error(ArgumentError)
      end
    end
  end
end
