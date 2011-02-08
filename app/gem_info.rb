require 'service/gem_testers'

class GemInfo < Struct.new(:gem_name, :version, :test_results)
  attr_reader 
  def self.query(gem_name, version, query_service = Service::GemTesters)
    result = query_service.test_information_for(gem_name, version)
    return new(gem_name, version) unless result['version']
    new gem_name, version, result['version']['test_results']
  end
  def initialize(gem_name, version, test_results = [])
    test_results.each {|data| data.delete("test_output") }
    super
  end
  def to_json(*args)
    {full_name => test_results}.to_json
  end
  def full_name
    "#{gem_name}-#{version}"
  end
end