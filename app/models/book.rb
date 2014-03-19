class Book < ActiveRecord::Base
  PER_PAGE = 10
  CATEGORY = {title: "Name", author: "Author", subject: "Subject"}.freeze

  class << self
    def search(params)
      client = Openlibrary::Client.new
      begin
        if params[:category].present?
          client.search({params[:category].to_sym => params[:query]}, page(params), PER_PAGE)
        else
          search_by_priority params, client
        end
      rescue Exception
        nil
      end
    end

    def page params
      params.has_key?(:page) ? params[:page].to_i : 1
    end

    # priorty: author, subject, normal search
    def search_by_priority(params, client)
      books, total = client.search params_find_by_author(params[:query]), page(params), PER_PAGE
      if total == 0
        books, total = client.search params_find_by_subject(params[:query]), page(params), PER_PAGE
      end

      if total == 0
        books, total = client.search params[:query], page(params), PER_PAGE
      end

      [books, total]
    end

    def params_find_by_author(query)
      {author: query}
    end

    def params_find_by_subject(query)
      {subject: query}
    end
  end
end
