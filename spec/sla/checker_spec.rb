require 'spec_helper'

describe Checker do
  let(:checker) { Checker.new }
  let(:base) { 'http://localhost:3000/' }

  describe '#on_check' do
    it "yields page objects as results" do
      checker.on_check base do |result| 
        expect(result).to be_a Page
      end
    end
  end

  describe '#check_url' do
    context "with not found url" do
      it "sets status to 404" do
        checker.check_url('http://localhost:3000/not-found', 10) do |page|
          expect(page.status).to eq '404'
        end
      end
    end

    context "with found url" do
      it "sets status to 200" do
        checker.check_url('http://localhost:3000/found', 10) do |page|
          expect(page.status).to eq '200'
        end
      end
    end
  end

  describe '#count' do
    it "returns the number of checked links" do
      checker.on_check base
      expect(checker.count).to eq 9
    end
  end

end