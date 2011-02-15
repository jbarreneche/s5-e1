require 'spec_helper'
require 'service/gem_testers'

describe Service::GemTesters do

  describe '.test_information_for' do

    it 'fetches the info for the given gem and the given version' do
      gem_name, version = "ruboto 0.3.0".split

      stub_request(:get, Service::GemTesters[gem_name, version])
        .to_return(:body => read_fixture(:tests, 'ruboto.json'))

      test_info = Service::GemTesters.test_information_for(gem_name, version)
      test_info.should have(12).test_data

    end
    
    it 'doesnt break when gem testers isnt available' do
      gem_name, version = "ruboto 0.3.0".split

      stub_request(:get, Service::GemTesters[gem_name, version])
        .to_return(:status => [500, "Internal Server Error"])

      expect {
        Service::GemTesters.test_information_for(gem_name, version)
      }.to raise_error(ServiceUnavailableError)

    end
  end
end