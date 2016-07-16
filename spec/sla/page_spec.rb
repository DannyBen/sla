# require 'spec_helper'

# describe Page do

#   describe '#new' do
#     let(:page) { Page.new 'http://localhost:3000/' }

#     it "sets default status" do
#       expect(page.status).to eq '000'
#     end
#   end

#   describe '#name' do
#     context "at root" do
#       let(:page) { Page.new 'http://localhost:3000/' }

#       it "returns the full url" do
#         expect(page.name).to eq 'http://localhost:3000/'
#       end
#     end

#     context "at sub pages" do
#       let(:page) { Page.new 'http://localhost:3000/found?with=query' }

#       it "returns the the request uri only" do
#         expect(page.name).to eq '/found?with=query'
#       end
#     end
#   end

#   describe '#valid?' do
#     context "for a valid page" do
#       let(:page) { Page.new 'http://localhost:3000/' }

#       it "returns true" do
#         expect(page.valid?).to be true
#       end
#     end

#     context "for an invalid page" do
#       let(:page) { Page.new 'http://localhost:3000/not-found' }

#       it "returns false" do
#         expect(page.valid?).to be false
#       end
#     end
#   end

# end