require 'spec_helper'

describe 'bin/sla' do
  it "works" do
    expect(`bin/sla`).to match_fixture('usage')
  end

  context "on failures" do
    it "fails gracefully" do
      expect(`bin/sla check localhost:3000`).to match_fixture('bin-fail')
    end
  end
end