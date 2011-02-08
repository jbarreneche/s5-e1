#!/usr/env ruby
$LOAD_PATH.unshift(::File.expand_path('../app',  __FILE__))

require 'bundler'
Bundler.setup
Bundler.require(:default)

require 'gem_authors_test_app'

run GemAuthorsTestApp