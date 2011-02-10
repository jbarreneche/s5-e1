require 'json'
require_relative 'gem_author'

class GemAuthorsTestApp < Sinatra::Base
  get '/:author' do |author|
    respond_with(author, GemAuthor.query(author))
  end
  def respond_with(author_name, author)
    unless author.nil?
      author.to_json
    else
      status '503'
      "Rubygems doesnt like your author: #{author_name.inspect}"
    end
  end
end