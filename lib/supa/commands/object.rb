require 'supa/command'

module Supa
  module Commands
    class Object < Supa::Command
      def represent
        value = with_getter? ? context.instance_exec(&getter) : context.send(name)

        tree[name] = {}

        Supa::Builder.new(context: value, tree: tree[name]).instance_exec(&block)
      end
    end
  end
end
