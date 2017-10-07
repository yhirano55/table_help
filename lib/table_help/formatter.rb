module TableHelp
  module Formatter
    module_function

    def format_attribute_name(name, collection_or_resource)
      return if name.blank?

      if collection_or_resource.respond_to?(:model)
        collection_or_resource.model.human_attribute_name(name)
      else
        collection_or_resource.class.human_attribute_name(name)
      end
    end

    def format_value(name, value)
      case value
      when DateTime, Time
        I18n.l(value)
      when Numeric
        (name.to_sym == :id) ? value : value.to_s(:delimited)
      when TrueClass, FalseClass
        value.to_s
      when NilClass
        name ? tag.em(:empty) : nil
      else
        value
      end
    end
  end
end
