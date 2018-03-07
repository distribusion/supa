module Supa
  class Command
    UnsupportedModifier = Class.new(StandardError)

    def initialize(subject, representer:, tree:, name:, options: {}, &block)
      @subject = subject
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

    def value
      return @value if defined?(@value)
      value = apply_render_flags(raw_value)
      @value = modifier ? @representer.send(modifier, value) : value
    rescue Exception => e
      require 'binding.pry'
      binding.pry
    end

    def modifier
      return @modifier if defined?(@modifier)

      if @options.key?(:modifier) && !@options[:modifier].is_a?(Symbol)
        raise UnsupportedModifier,
          "Object #{@options[:modifier].inspect} is not a valid modifier. Please provide symbolized method name."
      end

      @modifier = @options[:modifier]
    end

    def apply_render_flags(val)
      val
    end

    def raw_value
      exec_on_representer? ? value_from_representer : value_from_subject
    end

    def value_from_subject
      return @subject[getter] if @subject.is_a?(Hash)
      @subject.send(getter) if @subject
    end

    def value_from_representer
      @representer.send(getter)
    end

    def exec_on_representer?
      @options[:exec_context] == :representer
    end

    def getter
      @options[:getter] || @name
    end

    def hide_when_empty?
      @options.fetch(:hide_when_empty, false)
    end

    def empty_when_nil?
      @options.fetch(:empty_when_nil, false)
    end

    def hide?
      false
    end
  end
end
