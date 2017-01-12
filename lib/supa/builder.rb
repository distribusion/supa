require 'supa/commands/attribute'
require 'supa/commands/virtual'
require 'supa/commands/object'
require 'supa/commands/namespace'
require 'supa/commands/collection'
require 'supa/commands/append'

module Supa
  class Builder
    COMMANDS = %w(attribute virtual object namespace collection append).freeze

    COMMANDS.each do |command|
      klass = Supa::Commands.const_get(command.capitalize)

      define_method command do |name, getter = nil, options = {}, &block|
        klass.new(representer: representer,
                  context: context,
                  tree: tree,
                  name: name,
                  getter: getter,
                  options: options,
                  &block).represent
      end
    end

    def initialize(representer:, context:, tree:)
      @representer = representer
      @context = context
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
