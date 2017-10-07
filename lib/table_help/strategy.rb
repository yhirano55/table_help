module TableHelp
  class Strategy
    attr_reader :name, :symbol_or_proc

    def initialize(name, symbol_or_proc)
      @name = name
      @symbol_or_proc = symbol_or_proc
    end

    def to_value(record, context = nil)
      case symbol_or_proc
      when Symbol, String
        record.send(symbol_or_proc)
      when Proc
        context.capture { symbol_or_proc.call(record) }
      else
        record.send(name)
      end
    end
  end
end
