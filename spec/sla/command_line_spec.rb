require 'spec_helper'

describe CommandLine do
  let(:cli) { CommandLine }

  describe '#execute' do
    context "without arguments" do
      it "shows usage patterns" do
        expect { cli.execute }.to output(/Usage:/).to_stdout
      end
    end

    context "with check command" do
      let(:command) { %w[check http://localhost:3000/] }

      it "outputs report" do
        expect { cli.execute command }.to output_fixture('check1').to_stdout
      rescue BrokenLinks
      end

      context "with --external" do
        let(:command) { %w[check http://localhost:3000/ --external] }

        it "checks external links" do
          expect { cli.execute command }.to output_fixture('check2').to_stdout
        rescue BrokenLinks
        end
      end

    end
  end
end