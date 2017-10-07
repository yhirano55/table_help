module TableHelp
  module Helper
    def table_for(collection_or_resource, options = {})
      resolve_builder_from(collection_or_resource, options).tap { |this| yield this }.to_html
    end

    alias_method :attributes_table_for, :table_for

    private

      def resolve_builder_from(collection_or_resource, options)
        if collection_or_resource.respond_to?(:to_model)
          AttributesTableFor.new(collection_or_resource, self, options)
        else
          TableFor.new(collection_or_resource, self, options)
        end
      end
  end
end
