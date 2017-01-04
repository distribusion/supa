module Supa
  class Command
    def initialize(object, tree:, representer:, name:, options: {}, &block)
      @object = object
      @tree = tree
      @representer = representer
      @name = name
      @options = options
      @block = block
    end

    def represent
      raise NotImplementedError
    end

    private

    def get_value
      CommandContext.new(@object, @representer).call(@options.fetch(:getter, @name))
    end
  end
end
