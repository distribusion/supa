require "simplecov"
SimpleCov.start

$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'json'
require 'supa'

Dir[File.join(Dir.pwd, 'spec', 'support', '**', '*.rb')].each { |f| require f }
Dir[File.join(Dir.pwd, 'spec', 'fixtures', '**', '*.rb')].each { |f| require f }

require 'minitest/autorun'
require 'minitest/spec'
require 'minitest/benchmark'
require 'minitest/pride'
