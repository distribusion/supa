module Supa
  class Builder
    COMMANDS = %w(attribute virtual object namespace collection append).freeze

    def initialize(subject, representer:, tree:)
      @subject = subject
      @representer = representer
      @tree = tree
    end

    COMMANDS.each do |command|
      klass = Supa::Commands.const_get(command.capitalize)

      define_method(command) do |name, options = {}, &block|
        klass.new(@subject,
          representer: @representer,
          tree: @tree,
          name: name,
          options: options,
          &block).represent
      end
    end

    def to_hash
      @tree.to_hash
    end

    def to_json
      to_hash.to_json
    end
  end
end
