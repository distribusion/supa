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
        Supa::Builder.new(representee, representer: self, tree: {}).tap do |builder|
          builder.instance_exec(&self.class.definition)
        end.to_hash
      rescue Exception => e
        require 'binding.pry'
        binding.pry
      end

      def to_json
        Oj.dump(to_hash, mode: :strict)
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
