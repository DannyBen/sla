require 'spec_helper'

describe Cache do

  describe '#cache' do
    it "returns a webcache object" do
      subject = described_class.instance.cache
      expect(subject).to be_a WebCache
    end
  end

  describe '::life_to_seconds' do
    it "handles plain numbers" do
      subject = described_class.life_to_seconds '11'
      expect(subject).to eq 11
    end

    it "handles 11s as seconds" do
      subject = described_class.life_to_seconds '11s'
      expect(subject).to eq 11
    end

    it "handles 11m as minutes" do
      subject = described_class.life_to_seconds '11m'
      expect(subject).to eq 11 * 60
    end

    it "handles 11h as hours" do
      subject = described_class.life_to_seconds '11h'
      expect(subject).to eq 11 * 60 * 60
    end

    it "handles 11d as days" do
      subject = described_class.life_to_seconds '11d'
      expect(subject).to eq 11 * 60 * 60 * 24
    end
  end

end