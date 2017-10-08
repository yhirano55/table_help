module TableHelp
  module Formatter
    module_function

    def format_attribute_name(name, collection_or_resource)
      return if name.blank?
      TableHelp.config.formatter[:attribute_name].call(name, collection_or_resource)
    end

    def format_value(name, value)
      TableHelp.config.formatter[:value].call(name, value)
    end
  end
end
