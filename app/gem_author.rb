require_relative 'gem_info'
require_relative 'service/rubygems'

class GemAuthor
  attr_accessor :author, :gems
  
  def self.query(author_name, query_service = Service::Rubygems)

    gems = query_service.gems_for(author_name)
    
    return nil unless gems
    
    new(author_name, gems)

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