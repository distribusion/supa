require 'bundler/gem_tasks'
require 'rake/testtask'

Rake::TestTask.new(:test) do |t|
  t.libs << %w(spec lib)
  t.test_files = FileList['spec/**/*_spec.rb']
end

Rake::TestTask.new(:bench) do |t|
  t.libs << %w(spec lib)
  t.test_files = FileList['spec/benchmarks/**/*_bench.rb']
end

task :default => :test
