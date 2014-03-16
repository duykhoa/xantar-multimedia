class Book < ActiveRecord::Base
  CATEGORY = {title: "Name", author: "Author", subject: "Subject"}.freeze

  class << self
    def search params
      client = Openlibrary::Client.new

      client.search search_params(params)
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
