require_relative 'gem_info'
require_relative 'service/rubygems'

class GemAuthor
  attr_accessor :author, :gems
  
  def self.query(author_name, query_service = Service::Rubygems)

    gems = query_service.gems_for(author_name)
    return new(author_name, gems)

  rescue ServiceUnavailableError => e
    nil
  end

  def initialize(author, gems)
    self.gems   = gems.map {|name, version| GemInfo.query(name, version)}
    self.author = author
  end

  def to_json
    {
      'author' => self.author,
      'gems'   => self.gems,
    }.to_json
  end

end