require 'supa/commands/attribute'
require 'supa/commands/object'
require 'supa/commands/namespace'
require 'supa/commands/collection'
require 'supa/commands/polymorphic'

module Supa
  class Builder
    COMMANDS = %w(attribute object namespace collection polymorphic).freeze

    COMMANDS.each do |command|
      klass = Supa::Commands.const_get(command.capitalize)

      define_method command do |name, options = {}, &block|
        klass.new(context: context,
                  tree: tree,
                  name: name,
                  options: options,
                  &block).represent
      end
    end

    def initialize(context:, tree:)
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
    attr_reader :context, :tree
  end
end
