require 'spec_helper'

describe 'bin/sla' do
  it "works" do
    expect(`bin/sla`).to match_fixture('bin/usage').diff(1)
  end

  context "on failures" do
    it "fails gracefully" do
      expect(`bin/sla check localhost:3000`).to match_fixture('bin/fail')
    end
  end
end