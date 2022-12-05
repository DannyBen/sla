require 'spec_helper'

describe Command do
  subject { MisterBin::Runner.new handler: Command }

  before { ENV['SLA_ALLOW_FAILS'] = "1" }
  after  { ENV['SLA_ALLOW_FAILS'] = nil }

  describe "without arguments" do
    it "shows usage patterns" do
      expect { subject.run }.to output_approval('cli/usage')
    end
  end

  describe "--help" do
    it "shows help" do
      expect { subject.run ["--help"] }.to output_approval('cli/help')
    end
  end

  describe "--version" do
    it "shows version number" do
      expect { subject.run ["--version"] }.to output(/\d\.\d\.\d/).to_stdout
    end
  end

  context "check operation" do
    let(:command) { %w[localhost:3000] }

    it "outputs report" do
      expect { subject.run command }.to output_approval('cli/check')
    end

    describe '--verbose' do
      let(:command) { %w[localhost:3000 --verbose --external] }

      it "uses the Verbose formatter" do
        expect { subject.run command }.to output_approval('cli/check-verbose')
          .except(/ERR  failed to connect.*/, 'ERR  failed to connect')
      end
    end

    describe '--simple' do
      let(:command) { %w[localhost:3000 --simple --external] }

      it "uses the Simple formatter" do
        expect { subject.run command }.to output_approval('cli/check-simple')
          .except(/ERR  failed to connect.*/, 'ERR  failed to connect')
      end
    end

    describe "--depth" do
      let(:command) { %w[localhost:3000 --depth 1] }

      it "changes the max scan depth" do
        expect { subject.run command }.to output_approval('cli/check-depth')
      end
    end

    describe "--external" do
      let(:command) { %w[localhost:3000 --external --depth 2] }

      it "checks external pages as well" do
        expect { subject.run command }.to output_approval('cli/check-external')
          .except(/ERR  failed to connect.*/, 'ERR  failed to connect')
      end
    end

    describe "--ignore" do
      let(:command) { ["localhost:3000", "-v", "-d2", "--ignore", "whiskey roger" ] }

      it "omits urls containing any of the provided strings" do
        expect { subject.run command }.to output_approval('cli/check-ignore')
      end
    end

    context "when failing and SLA_ALLOW_FAILS is not set" do
      let(:command) { %w[http://localhost:3000/ --simple] }

      before { ENV['SLA_ALLOW_FAILS'] = nil }
      after  { ENV['SLA_ALLOW_FAILS'] = "1" }

      it "raises BrokenLinks error" do
        expect {
          expect { subject.run command }.to raise_error(BrokenLinks)
        }.to output_approval("cli/check-broken")
      end
    end
  end

end