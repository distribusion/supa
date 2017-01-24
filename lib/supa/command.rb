module Supa
  class Command
    def initialize(context, representer:, tree:, name:, options: {}, &block)
      @context = context
      @representer = representer
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
      !options[:modifier].nil?
    end

    def dynamic_value
      exec_on_representer? ? value_from_representer : value_from_object
    end

    def exec_on_representer?
      options[:exec_context] == :representer
    end

    def value_from_object
      return context[getter] if context.is_a?(Hash)
      return context.send(getter) if context.respond_to?(getter)
    end

    def value_from_representer
      representer.send(getter)
    end

    def getter
      options[:getter] || name
    end

    def render?
      Array(value).any? || @options[:render_empty]
    end

    def value
      raise NotImplementedError
    end

    def processed_value
      apply_modifier(value)
    end
  end
end
