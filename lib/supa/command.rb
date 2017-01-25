module Supa
  class Command
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
      raw_value = exec_on_representer? ? value_from_representer : value_from_subject
      modifier ? @representer.send(modifier, flagged_value(raw_value)) : flagged_value(raw_value)
    end

    def value_from_subject
      return @subject[getter] if @subject.is_a?(Hash)
      @subject.send(getter) if @subject
    end

    def value_from_representer
      @representer.send(getter)
    end

    def modifier
      @options.fetch(:modifier, false)
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

    def convert_to_empty_object(_object)
      raise NotImplementedError
    end
  end
end
