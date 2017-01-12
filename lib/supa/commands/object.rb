require 'supa/command'

module Supa
  module Commands
    class Object < Supa::Command
      def represent
        tree[name] = {}

        Supa::Builder.new(representable: representable, context: dynamic_value, tree: tree[name]).instance_exec(&block)
      end
    end
  end
end
