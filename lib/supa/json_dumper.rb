# frozen_string_literal: true

module Supa
  module JsonDumper
    module_function

    def dump(obj)
      if defined?(JRUBY_VERSION)
        require 'jrjackson'
        JrJackson::Json.dump(obj)
      else
        require 'oj'
        Oj.dump(obj, mode: :strict)
      end
    end
  end
end
