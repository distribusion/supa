module Supa
  module Representable
    def self.included(base)
      base.send :include, InstanceMethods
      base.extend ClassMethods
    end

    module InstanceMethods
      def initialize(representee)
        @representee = representee
      end

      def to_hash
        Supa::Builder.new(representer: self, context: representee, tree: {}).tap do |builder|
          builder.instance_exec(&self.class.definition)
        end.to_hash
      end

      def to_json
        to_hash.to_json
      end

      attr_reader :representee
    end

    module ClassMethods
      def define(&block)
        @definition = block
      end

      attr_reader :definition
    end
  end
end
