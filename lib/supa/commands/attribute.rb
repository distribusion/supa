module Supa
  module Commands
    class Attribute < Supa::Command
      def represent
        return if hide?

        @tree[@name] = value
      end

      private

      def hide?
        value.nil? && hide_when_nil?
      end

      def hide_when_nil?
        @options.fetch(:hide_when_nil, false)
      end
    end
  end
end
