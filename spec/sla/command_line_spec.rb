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
      let(:command) { %w[check http://localhost:3000/ --no-color] }

      it "outputs report" do
        expected = fixture :check1
        expect {cli.execute command}.to output(expected).to_stdout
      end

      context "with --external" do
        let(:command) { %w[check http://localhost:3000/ --no-color --external] }

        it "checks external links" do
          expected = fixture :check2
          expect {cli.execute command}.to output(expected).to_stdout
        end
      end

    end
  end
end