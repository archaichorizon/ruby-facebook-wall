require 'bundler/gem_tasks'
require 'rake/testtask'
require 'rake/rdoctask'

task :default => :test

Rake::TestTask.new do |t|
  t.libs << 'test'
  t.test_files = Dir.glob("#{File.dirname(__FILE__)}/test/**/*_test.rb").sort
  t.warning = true
  t.verbose = true
end

Rake::RDocTask.new do |rd|
  rd.main = 'README.rdoc'
  rd.rdoc_files.include 'README.rdoc', 'lib/**/*.rb'
  rd.rdoc_dir = 'doc'
end