require 'supa/command'

module Supa
  module Commands
    class Virtual < Supa::Command
      def represent
        tree[name] = static_value
      end
    end
  end
end
