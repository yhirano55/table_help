require "table_help/helper"

module TableHelp
  class Railtie < ::Rails::Railtie
    initializer "table_help.helper" do
      ActiveSupport.on_load :action_view do
        include TableHelp::Helper
      end
    end
  end
end
