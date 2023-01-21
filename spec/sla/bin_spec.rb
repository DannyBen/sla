require 'spec_helper'

describe 'bin/sla' do
  it 'outputs usage' do
    expect(`bin/sla`).to match_approval('bin/usage')
  end

  context 'when an error occurs' do
    it 'fails gracefully' do
      expect(`bin/sla localhost:3000 --simple`).to match_approval('bin/fail')
    end
  end
end
