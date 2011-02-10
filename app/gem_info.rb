require 'service/gem_testers'

class GemInfo < Struct.new(:gem_name, :version, :test_results)
  attr_reader 
  def self.query(gem_name, version, query_service = Service::GemTesters)
    result = query_service.test_information_for(gem_name, version)
    return new(gem_name, version) unless result['version']
    new gem_name, version, result['version']['test_results']
  end
  def initialize(gem_name, version, test_results = [])
    test_results.each {|data| clean_data(data) }
    super
  end
  def to_json(*args)
    {full_name => test_results}.to_json
  end
  def full_name
    "#{gem_name}-#{version}"
  end
private
  def clean_data(data)
    data.delete('id')
    data.delete('rubygem_id')
    data.delete('version_id')
    data.delete('test_output')
    data.delete('updated_at')
    data
  end
end