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
      if options[:getter].is_a?(Proc)
        context.instance_exec(&options[:getter])
      else
        context.is_a?(Hash) ? context[name] : context.send(name)
      end
    end
  end
end
