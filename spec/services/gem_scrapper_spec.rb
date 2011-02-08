require 'spec_helper'
require 'app/gem_scrapper'

describe GemScrapper do
  it 'mocks' do
    stub_request(:get, "https://rubygems.org/profiles/lucasefe").to_return(:body => File.read(File.expand_path('../../support/gems/lucasefe.html', __FILE__)))
    GemScrapper.gems_for('lucasefe').should == [
      ["themes_for_rails", "0.4.1"], ["base-generators", "0.2.2"], ["acts_as_audited_on_steroids", "0.1.1"], ["core-generators", "0.0.2"]
    ]
  end
end