module Supa
  module Commands
    class Attribute < Supa::Command
      def represent
        return if hide?

        @tree[@name] = value
      end

      private

      def hide?
        value.nil? && hide_when_empty?
      end
    end
  end
end
