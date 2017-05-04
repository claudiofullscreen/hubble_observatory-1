require "bundler/setup"
$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require "hubble_api_client"

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
