module Supa
  module Commands
    class Attributes < Supa::Command
      def initialize(subject, representer:, tree:, names:)
        @subject = subject
        @representer = representer
        @tree = tree
        @names = names
      end

      def represent
        @names.each do |name|
          @tree[name] = value_from_subject(name)
        end
      end
    end
  end
end
