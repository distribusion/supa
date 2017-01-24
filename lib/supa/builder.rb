module Supa
  class Builder
    COMMANDS = %w(attribute virtual object namespace collection append).freeze

    COMMANDS.each do |command|
      klass = Supa::Commands.const_get(command.capitalize)

      define_method command do |name, options = {}, &block|
        klass.new(context,
                  representer: representer,
                  tree: tree,
                  name: name,
                  options: options,
                  &block).represent
      end
    end

    def initialize(context, representer:, tree:)
      @context = context
      @representer = representer
      @tree = tree
    end

    def to_hash
      tree.to_hash
    end

    def to_json
      to_hash.to_json
    end

    private

    attr_reader :representer, :context, :tree
  end
end
