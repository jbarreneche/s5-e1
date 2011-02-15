require 'open-uri'
require 'json'

require_relative 'service_unavailable_error'

module Service
  module GemTesters

    URL_PATTERN = "http://gem-testers.org/gems/%{gem_name}/v/%{version}.json"

    def [](gem_name, version)
      URL_PATTERN % {:gem_name => gem_name, :version => version}
    end

    def test_information_for(gem_name, version)

      url = self[gem_name, version]

      full_data = JSON.parse open(url).read
      
      extract_test_results(full_data)
    
    rescue OpenURI::HTTPError => exc
      raise ServiceUnavailableError.new(url, exc.message)
    end

    def extract_test_results(full_data)
      if full_data['version']
        full_data['version']['test_results'] 
      else
        {}
      end
    end

    extend self

  end
end