module Supa
  module Commands
    class Attributes < Supa::Command
      def initialize(subject, representer:, tree:, names:, options:)
        @subject = subject
        @representer = representer
        @tree = tree
        @names = names
        @options = options
      end

      def represent
        @names.each do |name|
          Supa::Commands::Attribute.new(
            @subject, representer: @representer, tree: @tree, name: name, options: attribute_options
          ).represent
        end
      end

      private

      def attribute_options
        @attribute_options ||= { hide_when_nil: @options[:hide_when_nil] }
      end
    end
  end
end
