require 'open-uri'
require 'nokogiri'

require_relative 'service_unavailable_error'

module Service
  module Rubygems

    URL_PATTERN = "https://rubygems.org/profiles/%{author}"

    def [](author)
      URL_PATTERN % {:author => author}
    end

    def gems_for(author)

      document = Nokogiri::HTML.parse open(self[author])
      gems = extract_gems_from_document(document)

      return Hash[gems]

    rescue OpenURI::HTTPError => e
      ex = ServiceUnavailableError.new(e.message)
      ex.exception(e)
      raise ex
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