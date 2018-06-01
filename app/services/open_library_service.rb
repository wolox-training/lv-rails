class OpenLibraryService
  cattr_accessor :base_url_endpoint
  self.base_url_endpoint = 'https://openlibrary.org/'

  def book_info(isbn)
    @isbn = isbn.to_s.rjust(10, '0')

    response = HTTParty.get(self.class.base_url_endpoint + post_parameters, \
                            headers: { 'Content-Type' => 'application/json' })
    case response.code
    when 200..299
      book_data_hash(JSON.parse(response.body))
    else
      raise UnhandledResponseError
    end
  end

  private

  attr_accessor :isbn

  def book_data_hash(response) # rubocop:disable AbcSize
    raise ArgumentError, 'Incorrect ISBN' unless response.keys.include? "ISBN:#{isbn}"
    book_data = {}
    book_data[:isbn] = isbn
    book_data[:title] = response["ISBN:#{isbn}"]['title']
    book_data[:subtitle] = response["ISBN:#{isbn}"]['subtitle']
    book_data[:number_of_pages] = response["ISBN:#{isbn}"]['number_of_pages']
    book_data[:authors] = response["ISBN:#{isbn}"]['authors']&.map { |a| a['name'] }&.compact
    book_data[:authors] ||= [] # if not present, return empty array
    book_data
  end

  def post_parameters
    "api/books?bibkeys=ISBN:#{isbn}&format=json&jscmd=data"
  end
end
