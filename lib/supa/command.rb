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

    def value
      return instance_exec(&value_accessor) if value_accessor.respond_to?(:call)

      extracted_value = derived_value_from_object(@object) || derived_value_from_object(@representer)
      extracted_value ||= literal_value

      raise_no_method_error(value_accessor) if extracted_value.nil?
      extracted_value
    end

    def value_accessor
      @value_accessor ||= @options.fetch(:getter, @name)
    end

    def derived_value_from_object(object)
      if value_accessor.respond_to?(:to_sym) && object.respond_to?(value_accessor)
        object.send(value_accessor.to_sym)
      elsif object.is_a?(Hash)
        object.dig(value_accessor)
      end
    end

    def literal_value
      return if value_accessor.respond_to?(:call)
      value_accessor unless value_accessor.is_a?(Symbol) || value_accessor.is_a?(Enumerable)
    end

    def raise_no_method_error(method_sym)
      raise NoMethodError, "undefined method `#{method_sym}' for #{@object} or #{@representer}"
    end

    def method_missing(method_sym, *args, &block)
      return @representer.send(method_sym, *args, &block) if @representer.respond_to?(method_sym)
      return @object.send(method_sym, *args, &block) if @object.respond_to?(method_sym)

      raise_no_method_error(method_sym)
    end
  end
end
