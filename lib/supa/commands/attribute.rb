module Supa
  module Commands
    class Attribute < Supa::Command
      def represent
        @tree[@name] = value
      end

      private

      def flagged_value(non_flagged_value)
        non_flagged_value
      end
    end
  end
end
