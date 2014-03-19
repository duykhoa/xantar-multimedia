require 'spec_helper'

describe Book do
  describe ".params_find_by_author" do
    it "returns a params hash" do
      expect(Book.params_find_by_author("query").has_key?(:author)).to be_true
    end
  end

  describe ".params_find_by_subject" do
    it "returns a params hash" do
      expect(Book.params_find_by_subject("query").has_key?(:subject)).to be_true
    end
  end

  describe ".search_by_priority" do
    let!(:client) { double('Client') }

    context "query is a params" do
      it "returns an array" do
        allow(client).to receive(:search).and_return([[],0])
        client.should_receive(:search).exactly(3).times.and_return([[],0])
        results = Book.search_by_priority({query: "query"}, client)

        expect(results.is_a? Array).to be_true
        expect(results).to eq([[], 0])
      end
    end

    context "query is a subject" do
      it "returns an array" do
        allow(client).to receive(:search).and_return([[],0], [[:book], 1])
        client.should_receive(:search).exactly(2).times
        results = Book.search_by_priority({query: "query"}, client)

        expect(results.is_a? Array).to be_true
      end
    end

    context "query is a author" do
      it "returns an array" do
        allow(client).to receive(:search).and_return([[:author], 1])
        client.should_receive(:search).exactly(1).times
        results = Book.search_by_priority({query: "query"}, client)

        expect(results.is_a? Array).to be_true
      end
    end
  end

  describe ".search" do
    context "search by explicit category" do
      let!(:params) { {category: "title", query: "query"} }

      it "calls the normal search function" do
        client = double("Client")
        Openlibrary::Client.stub(:new).and_return(client)
        allow(client).to receive(:search).and_return([])

        Book.should_receive(:search_by_priority).exactly(0).times
        client.should_receive(:search).once
        Book.search(params)
      end
    end

    context "search by priority params" do
      let!(:params) { {category: "", query: "query"} }

      it "calls the priority search function" do
        client = double("Client")
        Openlibrary::Client.stub(:new).and_return(client)
        allow(client).to receive(:search).and_return([])

        client.should_receive(:search).exactly(0).times
        Book.should_receive(:search_by_priority).once
        Book.search(params)
      end
    end
  end
end
