require 'json'
require_relative 'gem_author'

class GemAuthorsTestApp < Sinatra::Base

  get '/:author' do |author|
    begin
      respond_with(author, GemAuthor.query(author))
    rescue ServiceUnavailableError => e
      status '503'
      "Problem with service #{e.service_url}, responded with error #{e.message}"
    end
  end

  def respond_with(author_name, author)
    unless author.nil?
      author.to_json
    else
      status '404'
      "Rubygems doesnt like your author: #{author_name.inspect}"
    end
  end

end