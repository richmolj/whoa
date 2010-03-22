require 'rubygems'
require 'rake'

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name = "whoa"
    gem.summary = %Q{Active-Recordy API to the Google Website Optimizer API (WO)}
    gem.description = %Q{Basic CRUD actions through an AR-style interface. Start/Stop experiments, get tracking snippets, add pages, etc.}
    gem.email = "lrichmond@customink.com"
    gem.homepage = "http://github.com/richmolj/whoa"
    gem.authors = ["richmolj@gmail.com"]
    gem.add_development_dependency "thoughtbot-shoulda", ">= 0"
    
    gem.add_dependency "happymapper", ">= 0.3.0"
    gem.add_dependency "rest-client", ">= 1.4.2"
    gem.add_dependency "active_support", ">= 2.3.0"
    # gem is a Gem::Specification... see http://www.rubygems.org/read/chapter/20 for additional settings
  end
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: gem install jeweler"
end

require 'rake/testtask'
Rake::TestTask.new(:test) do |test|
  test.libs << 'lib' << 'test'
  test.pattern = 'test/**/test_*.rb'
  test.verbose = true
end

begin
  require 'rcov/rcovtask'
  Rcov::RcovTask.new do |test|
    test.libs << 'test'
    test.pattern = 'test/**/test_*.rb'
    test.verbose = true
  end
rescue LoadError
  task :rcov do
    abort "RCov is not available. In order to run rcov, you must: sudo gem install spicycode-rcov"
  end
end

task :test => :check_dependencies

task :default => :test

require 'rake/rdoctask'
Rake::RDocTask.new do |rdoc|
  version = File.exist?('VERSION') ? File.read('VERSION') : ""

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "whoa #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end
