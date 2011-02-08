require 'nokogiri'
require 'open-uri'

module Service
  module Rubygems
    def gems_for(author)
      document = Nokogiri::HTML.parse open("https://rubygems.org/profiles/#{author}")
      gems = document.css('.profile-rubygem').map do |element|
        [element.children.first.text.strip, element.at_css('em').text.strip]
      end
      Hash[gems]
    end
    extend self
  end
end