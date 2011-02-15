require_relative 'service/gem_testers'

class GemInfo
  attr_accessor :gem_name, :version, :test_results
  
  def self.query(gem_name, version, query_service = Service::GemTesters)

    test_results = begin
      query_service.test_information_for(gem_name, version)
    rescue ServiceUnavailableError => e
      []
    end

    new(gem_name, version, test_results)

  end
  
  def initialize(gem_name, version, test_results)
    self.test_results = test_results.map {|data| clean_data(data) }
    self.gem_name     = gem_name
    self.version      = version
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