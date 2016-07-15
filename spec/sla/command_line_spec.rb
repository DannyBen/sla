require 'spec_helper'

describe CommandLine do
  let(:cli) { CommandLine.clone.instance }

  describe '#execute' do
    context "without arguments" do
      it "shows usage patterns" do
        expect {cli.execute}.to output(/Usage:/).to_stdout
      end
    end

    context "with check command" do
      let(:command) { %w[check http://localhost:3000/ --color] }

      it "outputs report" do
        expected = fixture :check1
        expect {cli.execute command}.to output(expected).to_stdout
      end
    end
  end

end