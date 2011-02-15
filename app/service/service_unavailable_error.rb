class ServiceUnavailableError < StandardError
  attr_reader :service_url
  def initialize(service_url, message)
    super(message)
    @service_url = service_url
  end
end
