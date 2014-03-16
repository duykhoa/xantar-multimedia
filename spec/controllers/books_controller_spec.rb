require 'spec_helper'

describe BooksController do
  describe "GET index" do
    it "returns success status" do
      get :index
      expect(response.status).to eq(200)
    end
  end

  describe "GET search" do
    it "returns success status" do
      get :search, {query: "book"}
      expect(response.status).to eq(200)
    end
  end
end
