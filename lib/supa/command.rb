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

    def dynamic_value
      exec_on_representer? ? value_from_representer : value_from_object
    end

    def value_from_object
      return @subject[getter] if @subject.is_a?(Hash)
      @subject.send(getter) if @subject.respond_to?(getter)
    end

    def value_from_representer
      @representer.send(getter)
    end

    def processed_value
      with_modifier? ? @representer.send(modifier, value) : value
    end

    # --------------------------------------------------------------------------

    def modifier
      @options[:modifier]
    end

    def with_modifier?
      !@options[:modifier].nil?
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

    def value
      raise NotImplementedError
    end
  end
end
