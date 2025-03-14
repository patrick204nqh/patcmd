# frozen_string_literal: true

require "patcmd"
require "tmpdir"
require "stringio"

# Require all files in spec/support
Dir[File.join(__dir__, "support/**/*.rb")].each { |f| require f }

RSpec.configure do |config|
  config.include(OutputHelper)

  # Global around hook to override the configuration file path for every test.
  config.around(:each) do |example|
    Dir.mktmpdir do |dir|
      RSpec::Mocks.with_temporary_scope do
        stub_const("Patcmd::Configuration::CONFIG_PATH", File.join(dir, "config.yml"))
        example.run
      end
    end
  end

  config.example_status_persistence_file_path = ".rspec_status"
  config.disable_monkey_patching!
  config.expect_with(:rspec) do |c|
    c.syntax = :expect
  end
end
