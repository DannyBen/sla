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
      let(:command) { %w[check localhost:3000 --color] }

      it "outputs report" do
        expected = fixture :check1
        expect {cli.execute command}.to output(expected).to_stdout
      end
    end

    # context "with get command" do
    #   let(:command) { %w[get datasets/WIKI/AAPL rows:5] }

    #   it "prints csv output" do
    #     expected = /Date,Open,High,Low,Close,Volume/
    #     expect {cli.execute command}.to output(expected).to_stdout
    #   end
    # end

    # context "with pretty command" do
    #   let(:command) { %w[pretty datasets/WIKI/AAPL rows:5] }

    #   it "prints a prettified json output" do
    #     expected = /"dataset_code": "AAPL",\n\s*"database_code": "WIKI"/
    #     expect {cli.execute command}.to output(expected).to_stdout
    #   end
    # end

    # context "with see command" do
    #   let(:command) { %w[see datasets/WIKI/AAPL rows:5] }

    #   it "awesome-prints output" do
    #     expected = /:dataset_code.*=>.*"AAPL"/
    #     expect {cli.execute command}.to output(expected).to_stdout
    #   end
    # end

    # context "with save command" do
    #   let(:command) { %W[save tmp.zip databases/#{premium}/data download_type:partial] }

    #   it "saves a file", type: :premium do
    #     File.unlink 'tmp.zip' if File.exist? 'tmp.zip'
    #     expect(File).not_to exist 'tmp.zip'
    #     expected = "Saved tmp.zip\n"

    #     expect {cli.execute command}.to output(expected).to_stdout
    #     expect(File).to exist 'tmp.zip'
    #     expect(File.size 'tmp.zip').to be > 10000

    #     File.unlink 'tmp.zip'
    #   end
    # end

    # context "with an invalid path" do
    #   let(:command) { %W[get not_here] }
      
    #   it "fails with honor" do
    #     expect {cli.execute command}.to output(/400 Bad Request/).to_stdout
    #   end
    # end

  end

end