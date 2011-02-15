require 'open-uri'
require 'json'

module Service
  module GemTesters
    URL_PATTERN = "http://gem-testers.org/gems/%{gem_name}/v/%{version}.json"

    def [](gem_name, version)
      URL_PATTERN % {:gem_name => gem_name, :version => version}
    end

    def test_information_for(gem_name, version)
      url = URI.parse self[gem_name, version]
      JSON.parse Net::HTTP.get(url)
    end

    extend self
  end
end