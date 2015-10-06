require 'rake/testtask'
require 'rdoc/task'

Rake::TestTask.new do |t|
  t.libs << 'test'
end

Rake::RDocTask.new do |rd|
  rd.rdoc_files.include("lib/ipcalc/*.rb")
  rd.rdoc_dir = 'doc'
end

desc "Run tests"
task :default => :test
