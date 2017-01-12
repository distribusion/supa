require 'supa/command'

module Supa
  module Commands
    class Collection < Supa::Command
      def represent
        tree[name] = []

        Array(dynamic_value).each do |element|
          tree[name] << {}

          Supa::Builder.new(representable: representable, context: element, tree: tree[name][-1]).instance_exec(&block)
        end
      end
    end
  end
end
