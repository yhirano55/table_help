module TableHelp
  class AttributesTableFor
    attr_reader :resource, :context, :options, :rows
    delegate :concat, :capture, :tag, to: :context

    def initialize(resource, context, options = {})
      @resource = resource
      @context  = context
      @options  = default_options.merge(options)
      @rows     = []
    end

    def row(name = nil, method_name = nil, &block)
      rows << [
        Formatter.format_attribute_name(name, resource),
        Strategy.new(name, block_given? ? block : method_name),
      ]
    end

    def to_html
      return if resource.nil?
      tag.table(tbody, options)
    end

    private

      def tbody
        tag.tbody do
          rows.each do |attr_name, strategy|
            concat(
              tag.tr do
                concat tag.th(attr_name)
                concat tag.td(Formatter.format_value(strategy.name, strategy.to_value(resource, context)), class: "col-#{strategy.name}")
              end,
            )
          end
        end
      end

      def default_options
        TableHelp.config.default_options[:attributes_table_for] || {}
      end
  end
end
