require 'supa/command'

module Supa
  module Commands
    class Polymorphic < Supa::Command
      def represent
        values = with_getter? ? context.instance_exec(&getter) : context.send(name)

        tree[name] ||= []

        Array(values).each do |value|
          tree[name] << {}

          Supa::Builder.new(context: value, tree: tree[name][-1]).instance_exec(&block)
        end
      end
    end
  end
end
