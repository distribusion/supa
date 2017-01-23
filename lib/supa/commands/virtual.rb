require 'supa/command'

module Supa
  module Commands
    class Virtual < Supa::Command
      def represent
        tree[name] = processed_value
      end

      private

      def value
        getter
      end
    end
  end
end
