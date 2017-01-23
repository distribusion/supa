require 'supa/command'

module Supa
  module Commands
    class Virtual < Supa::Command
      def represent
        tree[name] = processed_value
      end

      private

      def value
        static_value
      end
    end
  end
end
