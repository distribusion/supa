module Supa
  module Commands
    class Virtual < Supa::Command
      def represent
        @tree[@name] = value
      end

      private

      def raw_value
        getter
      end
    end
  end
end
