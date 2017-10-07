module TableHelp
  class Config
    attr_accessor :default_options

    def initialize
      @default_options = {
        table_for: {
          class: "table table-striped table-hover table_for",
        },
        attributes_table_for: {
          class: "table table-striped table-hover attributes_table_for",
        },
      }
    end
  end
end
