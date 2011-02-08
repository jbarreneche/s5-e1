require 'json'
require 'inquirer'
class GemAuthorsTestApp < Sinatra::Base
  get '/:author' do |author|
    {author => "Yahoo!"}.to_json
  end
end