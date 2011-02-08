require 'nokogiri'
require 'open-uri'
class GemScrapper
  def self.gems_for(author)
    document = Nokogiri::HTML.parse open("https://rubygems.org/profiles/#{author}")
    document.css('.profile-rubygem').map do |element|
      [element.children.first.text.strip, element.at_css('em').text.strip]
    end
  end
end