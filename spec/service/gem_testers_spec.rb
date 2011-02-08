require 'spec_helper'
require 'service/gem_testers'

describe Service::GemTesters do
  describe '.test_information_for' do
    it 'fetches the info for the given gem and the given version' do
      gem_name, version = "ruboto 0.3.0".split
      stub_request(:get, "http://gem-testers.org/gems/#{gem_name}/v/#{version}.json").to_return(:body => File.read(File.expand_path('../../support/tests/rubot.json', __FILE__)))
      Service::GemTesters.test_information_for(gem_name, version)['version']['number'].should == version
    end
  end
end