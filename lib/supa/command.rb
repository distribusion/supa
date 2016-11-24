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
      options[:getter].is_a?(Proc) ? context.instance_exec(&options[:getter]) : context.send(name)
    end
  end
end
