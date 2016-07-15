require 'spec_helper'

describe Cache do

  describe '#cache' do
    it "returns a webcache object" do
      subject = described_class.instance.cache
      expect(subject).to be_a WebCache
    end
  end

end