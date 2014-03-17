class Book < ActiveRecord::Base
  CATEGORY = {title: "Name", author: "Author", subject: "Subject"}.freeze
  PER_PAGE = 10

  class << self
    def search params
      client = Openlibrary::Client.new
      begin
        client.search search_params(params), page(params), PER_PAGE
      rescue Exception
        nil
      end
    end

    def page params
      params.has_key?(:page) ? params[:page].to_i : 1
    end

    def search_params params
      if params[:category].present? && CATEGORY.include?(params[:category].to_sym)
        {params[:category].to_sym => params[:query]}
      else
        params[:query]
      end
    end
  end
end
