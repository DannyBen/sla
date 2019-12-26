require 'spec_helper'

describe CommandLine do
  let(:cli) { CommandLine }
  before { ENV['SLA_ALLOW_FAILS'] = "1" }
  after  { ENV['SLA_ALLOW_FAILS'] = nil }

  describe '#execute' do
    context "without arguments" do
      it "shows usage patterns" do
        expect { cli.execute }.to output_fixture('usage')
      end
    end

    context "--help" do
      it "shows help" do
        expect { cli.execute ["--help"] }.to output_fixture('help')
      end
    end

    context "check" do
      let(:command) { %w[check http://localhost:3000/] }

      it "outputs report" do
        expect { cli.execute command }.to output_fixture('check')
      end

      context "--external" do
        let(:command) { %w[check http://localhost:3000/ --external] }

        it "checks external links" do
          expect { cli.execute command }.to output_fixture('check-external')
        end
      end

      context "--ignore" do
        let(:command) { ['check', 'http://localhost:3000/', '--ignore', "/roger /whiskey"] }

        it "skips URLs that start with the provided strings" do
          expect { cli.execute command }.to output_fixture('check-ignore')
        end
      end

      context "--log" do
        let(:command) { %w[check http://localhost:3000/ --log spec.log] }
        
        before do
          File.unlink "spec.log" if File.exist? "spec.log"
          expect(File).not_to exist "spec.log"
        end

        it "saves errors to log file" do
          expect { cli.execute command }.to output_fixture('check')
          expect(File.read 'spec.log').to match_fixture('logfile')
        end
      end

      context "when failing and SLA_ALLOW_FAILS is not set" do
        let(:command) { %w[check http://localhost:3000/] }

        before { ENV['SLA_ALLOW_FAILS'] = nil }
        after  { ENV['SLA_ALLOW_FAILS'] = "1" }

        it "raises BrokenLinks error" do
          expect {
            expect { cli.execute command }.to raise_error(BrokenLinks)
          }.to output_fixture("check")
        end
      end

    end
  end
end