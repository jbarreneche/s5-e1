require 'json'
require_relative 'gem_author'
class GemAuthorsTestApp < Sinatra::Base
  get '/:author' do |author|
    GemAuthor.query(author).to_json
  end
end