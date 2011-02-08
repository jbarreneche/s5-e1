require 'open-uri'
require 'json'

module Service
  module GemTesters
    def test_information_for(gem_name, version)
      JSON.parse Net::HTTP.get(URI.parse "http://gem-testers.org/gems/#{gem_name}/v/#{version}.json")
    end

    extend self
  end
end