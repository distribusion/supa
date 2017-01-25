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

    def midified_value
      with_modifier? ? @representer.send(modifier, value) : value
    end

    def midified_not_nil_value
      with_modifier? ? @representer.send(modifier, not_nil_value) : not_nil_value
    end

    def modifier
      @options[:modifier]
    end

    def with_modifier?
      !@options[:modifier].nil?
    end

    def dynamic_value
      exec_on_representer? ? value_from_representer : value_from_object
    end

    def exec_on_representer?
      @options[:exec_context] == :representer
    end

    def value_from_object
      return @subject[getter] if @subject.is_a?(Hash)
      return @subject.send(getter) if @subject.respond_to?(getter)
    end

    def value_from_representer
      @representer.send(getter)
    end

    def getter
      @options[:getter] || @name
    end

    def hide_when_empty?
      @options[:hide_when_empty] ||= false

      if value.is_a?(Array)
        not_nil_value.any? ? false : @options[:hide_when_empty]
      else
        value.nil? ? @options[:hide_when_empty] : false
      end
    end

    def convert_nil_to_object?
      @options[:empty_when_nil] ||= false
    end

    def convert_to_empty_object(_object)
      raise NotImplementedError
    end

    def value
      raise NotImplementedError
    end

    def processed_value
      return midified_not_nil_value if convert_nil_to_object?
      midified_value
    end
  end
end
