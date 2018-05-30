class OpenLibraryService
  def book_info(url)
    response = response_hash_parsed(url)
    isbn = find_isbn_in(url)

    title = extract_property(response, isbn, 'title')
    subtitle = extract_property(response, isbn, 'subtitle')
    number_of_pages = extract_property(response, isbn, 'number_of_pages')

    authors_list_hash = extract_property(response, isbn, 'authors')
    authors = authors_list_hash.map { |author| author['name'] }.to_a

    Hash.new(isbn: isbn, title: title, subtitle: subtitle, \
             number_of_pages: number_of_pages, authors: authors)
  end

  private

  def response_hash_parsed(url)
    response = HTTParty.get(url, format: :plain)
    JSON.parse response
  end

  def find_isbn_in(url)
    response = response_hash_parsed(url)
    response.keys.select { |key| key.include?('ISBN') }.first
  end

  def extract_property(hash_parsed, isbn, string_property)
    hash_parsed[isbn][string_property]
  end
end
