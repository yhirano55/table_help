module TableHelp
  class TableFor
    attr_reader :collection, :context, :options, :column_names, :strategies
    delegate :concat, :capture, :tag, to: :context

    def initialize(collection, context, options = {})
      @collection   = collection
      @context      = context
      @options      = default_options.merge(options)
      @column_names = []
      @strategies   = []
    end

    def column(name = nil, method_name = nil, &block)
      column_names << Formatter.format_attribute_name(name, collection)
      strategies << Strategy.new(name, block_given? ? block : method_name)
    end

    def to_html
      return if collection.empty?

      tag.table(options) do
        concat thead
        concat tbody
      end
    end

    private

      def thead
        tag.thead do
          tag.tr do
            column_names.each do |column_name|
              concat tag.th(column_name)
            end
          end
        end
      end

      def tbody
        tag.tbody do
          collection.each do |record|
            concat(
              tag.tr(class: "table-row-#{record.model_name.singular}#{record.to_param}") do
                strategies.each do |strategy|
                  concat tag.td(Formatter.format_value(strategy.name, strategy.to_value(record, context)), class: "col-#{strategy.name}")
                end
              end,
            )
          end
        end
      end

      def default_options
        TableHelp.config.default_options[:table_for] || {}
      end
  end
end
