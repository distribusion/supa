module Supa
  module Commands
    class Attributes < Supa::Command
      def represent
        names.each do |name|
          Supa::Commands::Attribute.new(
            @subject, representer: @representer, tree: @tree, name: name, options: @options
          ).represent
        end
      end

      private

      def names
        @name
      end
    end
  end
end
