#!/usr/bin/env rake
require 'bundler/gem_tasks'
require 'rake/clean'
require 'rake/testtask'
require 'rdoc-readme/rake_task'
require 'rdoc/task'

%w{ coverage goz.log html out.txt pkg }.each { |p| CLEAN.include(p) }
%w{ build install rdoc test }.each   { |t| task t.to_sym => [ 'rdoc:readme' ] }
    
task :default => :test

Rake::TestTask.new do |t|
  t.libs       << 'test'
  t.test_files =   FileList['test/test*.rb']
  t.verbose    =   true
end 

RDoc::Readme::RakeTask.new 'lib/jgrouper.rb', 'README.rdoc'

RDoc::Task.new do |rdoc|
  rdoc.main = 'README.rdoc'
  rdoc.rdoc_files.include('README.rdoc', 'lib/**/*.rb', 'doc/*.txt')
end

