module Supa
  module Commands
    class Attributes < Supa::Command
      def represent
        names.each do |name|
          Supa::Commands::Attribute.new(
            @subject, representer: @representer, tree: @tree, name: name, options: attribute_options
          ).represent
        end
      end

      private

      def names
        @name
      end

      def attribute_options
        @attribute_options ||= { hide_when_empty: @options[:hide_when_empty] }
      end
    end
  end
end
