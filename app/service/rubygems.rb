require 'net/http'
require 'nokogiri'

require_relative 'service_unavailable_error'

module Service
  module Rubygems

    URL_PATTERN = "http://rubygems.org/profiles/%{author}"

    def [](author)
      URL_PATTERN % {:author => author}
    end

    def gems_for(author)
      
      response = Net::HTTP.get_response URI.parse(self[author])

      case response
      when Net::HTTPSuccess
        document = Nokogiri::HTML.parse response.read_body

        gems = extract_gems_from_document(document)

        return Hash[gems]

      when Net::HTTPInternalServerError
        nil
        
      else
        raise ServiceUnavailableError.new(self[author], "#{response.code} #{response.message}")
      end
    end

    def extract_gems_from_document(document)
      document.css('.profile-rubygem').map do |element|

        gem_name_node    = element.children.first
        gem_version_node = element.at_css('em')

        [gem_name_node.text.strip, gem_version_node.text.strip]

      end
    end

    extend self

  end
end