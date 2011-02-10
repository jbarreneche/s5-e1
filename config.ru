#!/usr/env ruby

require 'bundler'
Bundler.setup
Bundler.require(:default)

require File.expand_path('../app/gem_authors_test_app', __FILE__)

run GemAuthorsTestApp