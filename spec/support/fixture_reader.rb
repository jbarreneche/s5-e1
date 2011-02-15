module FixtureReader
  def read_fixture(type, name)
    File.read File.expand_path("../../fixtures/#{type}/#{name}", __FILE__)
  end
end