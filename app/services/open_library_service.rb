class OpenLibraryService
  cattr_accessor :base_url_endpoint
  self.base_url_endpoint = 'https://openlibrary.org/'

  def book_info(isbn) # rubocop:disable Metrics/MethodLength
    @isbn = isbn.to_s.rjust(10, '0')

    response = HTTParty.get(self.class.base_url_endpoint + post_parameters(isbn), \
                            headers: { 'Content-Type' => 'application/json' })
    case response.code
    when 422
      InvalidLibrary.new
    when 200..299
      book_data_hash(JSON.parse(response))
    else
      raise UnhandledResponseError
    end
  end

  private

  attr_accessor :isbn

  def book_data_hash(response) # rubocop:disable AbcSize, Metrics/MethodLength
    raise ArgumentError, 'Incorrect ISBN' unless response.keys.include? "ISBN:#{isbn}"

    book_data = {}
    book_data[:isbn] = isbn
    book_data[:title] = response["ISBN:#{isbn}"]['title']
    book_data[:subtitle] = response["ISBN:#{isbn}"]['subtitle']
    book_data[:number_of_pages] = response["ISBN:#{isbn}"]['number_of_pages']
    book_data[:authors] = if response["ISBN:#{isbn}"]['authors'].present?
                            response["ISBN:#{isbn}"]['authors'].map { |author| author['name'] }.to_a # rubocop:disable Metrics/LineLength
                          else
                            []
                          end
    book_data
  end

  def post_parameters(isbn)
    "api/books?bibkeys=ISBN:#{isbn}&format=json&jscmd=data"
  end
end
