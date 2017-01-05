require 'simplecov'
SimpleCov.start

$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)

require 'supa'

require 'json'
require 'pry-byebug'
require 'rspec/core'
require 'rspec/benchmark'
require 'rspec/expectations'

Dir[File.join(Dir.pwd, 'spec', 'support', '**', '*.rb')].each { |f| require f }
Dir[File.join(Dir.pwd, 'spec', 'fixtures', '**', '*.rb')].each { |f| require f }

RSpec.configure do |config|
  config.include RSpec::Benchmark::Matchers

  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.shared_context_metadata_behavior = :apply_to_host_groups
  config.raise_errors_for_deprecations!
  config.warnings = true
end
