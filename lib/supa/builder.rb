module Supa
  class Builder
    COMMANDS_WITH_DEFAULT_INTERFACE = %w(attribute virtual object namespace collection append).freeze

    def initialize(subject, representer:, tree:)
      @subject = subject
      @representer = representer
      @tree = tree
    end

    COMMANDS_WITH_DEFAULT_INTERFACE.each do |command|
      klass = Supa::Commands.const_get(command.capitalize)

      define_method(command) do |name, **options, &block|
        klass.new(@subject,
          representer: @representer,
          tree: @tree,
          name: name,
          options: options,
          &block).represent
      end
    end

    def attributes(*names, **options)
      Supa::Commands::Attributes.new(
        @subject, representer: @representer, tree: @tree, name: names, options: options
      ).represent
    end

    def to_hash
      @tree.to_hash
    end

    def to_json
      Oj.dump(to_hash, mode: :strict)
    end
  end
end
