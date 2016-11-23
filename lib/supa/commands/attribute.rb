require 'supa/command'

module Supa
  module Commands
    class Attribute < Supa::Command
      def represent
        value = with_getter? ? context.instance_exec(&getter) : context.send(name)

        tree[name] = value
      end
    end
  end
end
