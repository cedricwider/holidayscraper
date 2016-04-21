require "bundler/gem_tasks"
require "rspec/core/rake_task"
require "rdoc/task"

RSpec::Core::RakeTask.new(:spec)

desc 'generate API documentation to doc/rdocs/index.html'
RDoc::Task.new do |rdoc|
  rdoc.rdoc_files.include('lib/**/*.rb')
end

task :default => :spec
task :test => :spec
