module Openlibrary
  module Search
    # Access the Openlibrary free-text search.
    # This API is experimental but useful (http://openlibrary.org/dev/docs/api/search)
    # This implementation only supports the first 100 results for simplicity

    # Possible search parameter keys include
    # :q (cross-field query)
    # :author
    # :publisher
    # :isbn
    # :title
    # :person
    # :place
    # :subject

    def search(search_params, page=1, limit=50, offset=0)
      processed_params = search_params.is_a?(String) ? {q: search_params} : search_params
      processed_params.merge!({page: page, limit: limit})
      puts processed_params
      data = request("/search.json", params: processed_params)
      results = []
      data["docs"].each do |result|
        results << Hashie::Mash.new(result)
      end
      [results, data["num_found"]]
    end
  end

  module Books
    require 'open-uri'

    def book(olid)
      url = "https://openlibrary.org/api/books?bibkeys=OLID:#{olid}&format=json&jscmd=data"
      JSON.load(open(url)).values.first
    end
  end
end
