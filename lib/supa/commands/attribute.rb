require 'supa/command'

module Supa
  module Commands
    class Attribute < Supa::Command
      def represent
        tree[name] = processed_value if render?
      end

      private

      def value
        dynamic_value
      end
    end
  end
end
