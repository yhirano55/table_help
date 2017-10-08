module TableHelp
  class Config
    DEFAULT_OPTIONS = {
      table_for: {
        class: "table table-striped table-hover table_for",
      },
      attributes_table_for: {
        class: "table table-striped table-hover attributes_table_for",
      },
    }.freeze

    DEFAULT_FORMATTER = {
      attribute_name: ->(name, collection_or_resource) do
        if collection_or_resource.respond_to?(:model)
          collection_or_resource.model.human_attribute_name(name)
        else
          collection_or_resource.class.human_attribute_name(name)
        end
      end,
      value: ->(name, value) do
        case value
        when DateTime, Time
          I18n.l(value)
        when Numeric
          (name.to_sym == :id) ? value : value.to_s(:delimited)
        else
          value
        end
      end,
    }.freeze

    attr_accessor :default_options, :formatter

    def initialize
      @default_options = DEFAULT_OPTIONS
      @formatter = DEFAULT_FORMATTER
    end
  end
end
