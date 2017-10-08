$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), "..", "lib"))
$LOAD_PATH.unshift(File.dirname(__FILE__))
# load Rails first
require "rails"

# load the plugin
require "table_help"

# needs to load the app next
require "fake_app/application"

require "capybara/rspec"
require "capybara/rails"
require "pry"

RSpec.configure do |config|
  config.example_status_persistence_file_path = ".rspec_status"
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end

CreateArticles.migrate(:up) unless ActiveRecord::Base.connection.table_exists? "articles"
