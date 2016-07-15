require 'spec_helper'

describe Link do

  describe '#path' do
    let(:link) { Link.new 'click me', 'http://example.com/hello?world' }

    it "returns the request uri" do
      expect(link.path).to eq '/hello?world'
    end
  end

end