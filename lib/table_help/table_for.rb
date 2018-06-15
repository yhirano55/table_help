module TableHelp
  class TableFor
    Column = Struct.new(:name, :human_name)

    attr_reader :collection, :context, :options, :columns, :strategies, :q
    delegate :concat, :capture, :tag, :sort_link, to: :context

    def initialize(collection, context, options = {})
      @collection   = collection
      @context      = context
      @options      = default_options.merge(options)
      @columns      = []
      @strategies   = []
      @q            = @options.delete(:q)
    end

    def column(name = nil, method_name = nil, &block)
      columns << Column.new(name, Formatter.format_attribute_name(name, collection))
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
            columns.each do |column|
              if sortable?
                concat tag.th(sort_link(q, column.name, column.human_name))
              else
                concat tag.th(column.human_name)
              end
            end
          end
        end
      end

      def sortable?
        !q.nil? && respond_to?(:sort_link)
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
