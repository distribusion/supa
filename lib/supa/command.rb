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
      return instance_exec(&method) if method.is_a?(Proc)
      return @object.send(method) if @object.respond_to?(method)
      return @object[method] if @object.is_a?(Hash) && @object.key?(method)
      return @representer.send(method) if @representer.respond_to?(method)

      raise_no_method_error(method)
    end

    def method
      @method ||= @options.fetch(:getter, @name)
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
