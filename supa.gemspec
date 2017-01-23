# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'supa/version'

Gem::Specification.new do |spec|
  spec.name          = 'supa'
  spec.version       = Supa::VERSION
  spec.platform      = Gem::Platform::RUBY
  spec.authors       = ['dasnotme', 'Jan Rietema', 'Jakub Gorzelak' , 'SamyRai']
  spec.email         = %w(
    info@distribusion.com
    jan.rietema@distribusion.com
    jakub.gorzelak@distribusion.com
    damir.mukimov@distribusion.com
  )

  spec.summary       = 'Ruby object → JSON serialization.'
  spec.description   = 'Ruby object → JSON serialization.'
  spec.homepage      = 'https://github.com/distribusion/supa'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.13'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'rspec-benchmark', '~> 0.2.0'
  spec.add_development_dependency 'rubocop', '~> 0.45.0'
  spec.add_development_dependency 'reek', '~> 4.5.0'
  spec.add_development_dependency 'simplecov', '~> 0.12'
  spec.add_development_dependency 'codeclimate-test-reporter', '~> 1.0.0'
  spec.add_development_dependency 'pry-byebug', '~> 3.4.0'
end
