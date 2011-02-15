require 'bundler'
Bundler.setup
Bundler.require(:default, :test)

require 'webmock/rspec'

Dir[File.join(File.dirname(__FILE__), 'support', '**', '*.rb')].each {|f| require f }

RSpec.configure do |c|
  c.include FixtureReader
end