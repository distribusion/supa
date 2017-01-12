module Supa
  class Command
    def initialize(representer:, context:, tree:, name:, options: {}, &block)
      @representer = representer
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
    attr_reader :representer, :context, :tree, :name, :options, :block

    def apply_modifier(value)
      with_modifier? ? representer.send(modifier, value) : value
    end

    def modifier
      options[:modifier]
    end

    def with_modifier?
      !!options[:modifier]
    end

    def static_value
      value = getter

      apply_modifier(value)
    end

    def dynamic_value
      value = if exec_on_object?
        value_from_object
      else
        value_from_representer
      end

      apply_modifier(value)
    end

    def exec_on_object?
      options[:exec_context] != :representer
    end

    def value_from_object
      context.is_a?(Hash) ? context[getter] : context.send(getter)
    end

    def value_from_representer
      representer.send(getter)
    end

    def getter
      options[:getter] || @name
    end
  end
end
