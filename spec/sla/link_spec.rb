require 'spec_helper'

describe Link do

  describe '#uri' do
    let(:link) { Link.new 'http://example.com/' }

    it "returns a uri object" do
      expect(link.uri).to be_a URI::Generic
    end
  end

  describe '#path' do
    let(:link) { Link.new 'http://example.com/hello?world' }

    it "returns the request uri" do
      expect(link.path).to eq '/hello?world'
    end
  end

  describe '#full_uri' do
    context "when relative" do
      let(:link) { Link.new 'bubble' }

      context "with parent url" do
        it "merges with the parent" do
          link.parent = 'http://dot.com/'
          expect(link.full_uri.to_s).to eq 'http://dot.com/bubble'
        end
      end

      context "without parent url" do
        it "returns the relative url" do
          expect(link.full_uri.to_s).to eq 'bubble'
        end
      end
    end

    context "when absolute" do
      let(:link) { Link.new 'http://dot.com/bubble' }

      it "returns the url itself" do
        link.parent = 'http://ignore.me/'
        expect(link.full_uri.to_s).to eq 'http://dot.com/bubble'
      end
    end
  end

end