require 'gem_info'
require 'service/rubygems'

class GemAuthor < Struct.new(:author, :gems)
  def self.query(author_name, query_service = Service::Rubygems)
    gems = query_service.gems_for(author_name)
    new(author_name, gems)
  rescue ServiceUnavailableError => e
    {}
  end
  def initialize(author, gems)
    gems = gems.map {|gem_name, version| GemInfo.query(gem_name, version)}
    super(author, gems)
  end
  def to_json
    {
      'author' => self.author,
      'gems' => self.gems
    }.to_json
  end
end