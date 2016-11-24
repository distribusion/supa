require 'supa/command'

module Supa
  module Commands
    class Attribute < Supa::Command
      def represent
        tree[name] = get_value
      end
    end
  end
end
