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
      it "return an array" do
        allow(client).to receive(:search).and_return([[],0])
        client.should_receive(:search).exactly(3).times.and_return([[],0])
        results = Book.search_by_priority({query: "query"}, client)

        expect(results.is_a? Array).to be_true
        expect(results).to eq([[],0])
      end
    end

    context "query is a subject" do
      it "return an array" do
        allow(client).to receive(:search).and_return([[],0], [[:book], 1])
        client.should_receive(:search).exactly(2).times
        results = Book.search_by_priority({query: "query"}, client)

        expect(results.is_a? Array).to be_true
      end
    end

    context "query is a author" do
      it "return an array" do
        allow(client).to receive(:search).and_return([[:author], 1])
        client.should_receive(:search).exactly(1).times
        results = Book.search_by_priority({query: "query"}, client)

        expect(results.is_a? Array).to be_true
      end
    end
  end
end
