require 'spec_helper'

describe Checker do
  let(:checker) { Checker.new }
  let(:base) { 'http://localhost:3000/' }

  describe '#check' do
    it "yields link objects as results" do
      checker.check base do |result| 
        expect(result).to be_a Link
      end
    end

    context "with not found url" do
      it "sets status to 404" do
        checker.check('http://localhost:3000/not-found') do |link|
          expect(link.status).to eq '404'
        end
      end
    end

    context "with found url" do
      it "sets status to 200" do
        checker.check('http://localhost:3000/found') do |link|
          expect(link.status).to eq '200'
        end
      end
    end
  end

  describe '#count' do
    it "returns the number of checked links" do
      checker.check base
      expect(checker.count).to eq 9
    end
  end

end