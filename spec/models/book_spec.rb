require 'spec_helper'

describe Book do
  describe ".search_params" do
    context "with cateory name" do
      let!(:params) { {category: "title", query: "book"} }

      it "returns search params with category key" do
        expect(Book.search_params(params)).to include(:title)
      end
    end

    context "without cateory name" do
      let!(:params) { {query: "book"} }

      it "returns search params with category key" do
        expect(Book.search_params(params)).to eq("book")
      end
    end
  end
end
