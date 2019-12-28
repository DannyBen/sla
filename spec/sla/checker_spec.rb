require 'spec_helper'

describe Checker do
  subject { Checker.new }
  let(:url) { 'http://localhost:3000/' }
  let(:page) { Page.new url }

  describe '#check' do
    it "yields action code and page object" do
      subject.check page do |action, page|
        expect(action).to satisfy do |value|
          [:source, :check, :skip].include?(value)
        end

        expect(page).to be_a Page
      end
    end
  end
end
