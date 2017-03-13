$LOAD_PATH << File.expand_path('../lib')

require 'es_http_client'
Dir['spec/support/**/*.rb'].each {|f| require_relative "../#{f}" }

class FakeResponse < Struct.new(:headers, :body); end

RSpec.configure do |config|

  config.disable_monkey_patching!
  config.warnings = true

  if config.files_to_run.one?
    config.default_formatter = 'doc'
  end

  config.order = :random
  Kernel.srand config.seed

  config.include RandomHelpers

  config.alias_it_should_behave_like_to :it_is, 'it is'

  config.mock_with :rspec do |mocks|
    mocks.verify_doubled_constant_names = true
  end
end
