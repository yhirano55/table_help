require "table_help/version"

module TableHelp
  module_function

  def configure
    yield(config)
  end

  def config
    @_config ||= Config.new
  end
end

require "table_help/config"
require "table_help/formatter"
require "table_help/strategy"
require "table_help/table_for"
require "table_help/attributes_table_for"
require "table_help/railtie" if defined?(Rails)
