require 'spec_helper'
require 'service/rubygems'

describe Service::Rubygems do
  describe '.gems_for' do
    it 'fetches the info for the author' do
      author = 'lucasefe'

      stub_request(:get, Service::Rubygems[author])
        .to_return(:body => read_fixture(:gems, "#{author}.html"))

      Service::Rubygems.gems_for(author).should == {
        "themes_for_rails"            => "0.4.1", 
        "base-generators"             => "0.2.2", 
        "acts_as_audited_on_steroids" => "0.1.1", 
        "core-generators"             => "0.0.2",
      }
    end

    it 'doesnt break when the author doesnt exist' do
      author = 'lucasefe'

      stub_request(:get, Service::Rubygems[author])
        .to_return(:status => [500, "Internal Server Error"])

      expect {
        Service::Rubygems.gems_for(author)
      }.to raise_error(ServiceUnavailableError)

    end
  end
end