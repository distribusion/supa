module Supa
  class Builder
    COMMANDS = %w(attribute object namespace collection).freeze

    COMMANDS.each do |command|
      klass = Supa::Commands.const_get(command.capitalize)

      define_method command do |name, options = {}, &block|
        klass.new(
          @object,
          tree: @tree,
          representer: @representer,
          name: name,
          options: options,
          &block
        ).represent
      end
    end

    def initialize(object, tree:, representer:)
      @object = object
      @tree = tree
      @representer = representer
    end

    def to_hash
      @tree.to_hash
    end

    def to_json
      to_hash.to_json
    end
  end
end
