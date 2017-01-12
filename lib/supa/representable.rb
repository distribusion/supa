module Supa
  module Representable
    def self.included(base)
      base.send :include, InstanceMethods
      base.extend ClassMethods
    end

    module InstanceMethods
      def initialize(object)
        @object = object
      end

      def to_hash
        Supa::Builder.new(representer: self, context: object, tree: {}).tap do |builder|
          builder.instance_exec(&self.class.definition)
        end.to_hash
      end

      def to_json
        to_hash.to_json
      end

      private

      attr_reader :object
    end

    module ClassMethods
      def define(&block)
        @definition = block
      end

      attr_reader :definition
    end
  end
end
