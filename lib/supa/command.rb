module Supa
  class Command
    def initialize(context:, tree:, name:, options: {}, &block)
      @context = context
      @tree = tree
      @name = name
      @options = options
      @block = block
    end

    def represent
      raise NotImplementedError
    end

    private
    attr_reader :context, :tree, :name, :options, :block

    def get_value
      case options[:getter]
      when Proc
        context.instance_exec(&options[:getter])
      when Hash
        context[name]
      else
        context.send(name)
      end
    end
  end
end
