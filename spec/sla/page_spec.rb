require 'spec_helper'

describe Page do
  subject { described_class.new url }
  let(:url) { "localhost:3000" }

  describe '#initialize' do
    context "with a string URI" do
      it "converts the string to a URI object" do
        expect(subject.uri).to be_a URI
        expect(subject.url).to eq "http://#{url}"
      end
    end

    context "with a URI object" do
      let(:url) { URI.parse "http://example.com" }

      it "works" do
        expect(subject.uri).to eq url
      end
    end
  end

  describe '#error' do
    context "when the page is valid" do
      it "returns nil" do
        expect(subject.error).to be_nil
      end
    end

    context "when the page is not found" do
      let(:url) { "localhost:3000/notfound" }

      it "returns the error message" do
        expect(subject.error).to match(/404 Not Found/)
      end
    end
  end

  describe '#external' do
    context "when the parent page has a different host" do
      subject { Page.new "example.com", parent: Page.new("localhost:3000") }

      it "returns true" do
        expect(subject.external?).to be true
      end
    end
    
    context "when the parent page has the same host" do
      subject { Page.new "example.com/page", parent: Page.new("example.com") }

      it "returns false" do
        expect(subject.external?).to be false
      end
    end
  end

  describe '#pages' do
    it "returns an array of linked pages" do
      expect(subject.pages).to be_an Array
      expect(subject.pages.first).to be_a Page
    end

    it "sets the depth of each page to self.depth + 1" do
      expect(subject.pages.first.depth).to eq 1
      expect(subject.pages.first.pages.first.depth).to eq 2
    end
  end

  describe '#url' do
    it "returns a string URL" do
      expect(subject.url).to eq "http://localhost:3000"
    end
  end

  describe '#valid?' do
    context "when the page exists" do
      it "returns true" do
        expect(subject).to be_valid
      end
    end

    context "when the page does not exist" do
      let(:url) { "localhost:3000/notfound" }

      it "returns false" do
        expect(subject).not_to be_valid
      end
    end
  end

  describe '#uri' do
    it "returns a URI object" do
      expect(subject.uri).to be_a URI::HTTP
    end
  end
end