require 'spec_helper'
require 'gem_author'

describe GemAuthor do

  describe '.query' do
    it 'delegates the data fetch to the service' do
      qs = mock("QueryService")
      qs.should_receive(:gems_for).with('author') { [] }
      author = GemAuthor.query('author', qs) 
      author.author.should == 'author'
      author.gems.should == []
    end
  end

  describe 'new instances' do

    it 'queries each gem data with GemInfo.query' do
      
      (1..2).each do |n| 
        name = "gem-#{n}"
        version = "#{n}.#{n}"
        GemInfo.should_receive(:query).with(name, version) { n }.ordered
      end
      
      author = GemAuthor.new 'author', [['gem-1', '1.1'], ['gem-2', '2.2']]
      author.gems.should == [1, 2]

    end

    it 'remembers author information' do
      author = GemAuthor.new 'author', []
      author.author.should == 'author'
    end

  end
end