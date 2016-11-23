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

    def with_getter?
      options[:getter].is_a?(Proc)
    end

    def getter
      options[:getter]
    end
  end
end
