require 'bundler/gem_tasks'
require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new(:spec)

task default: :spec

Rake::TestTask.new(:bench) do |t|
  t.libs << %w(spec lib)
  t.test_files = FileList['spec/benchmarks/**/*_bench.rb']
end
