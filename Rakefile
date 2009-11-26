require 'rubygems'
require 'rake'

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gemspec|
    gemspec.rubyforge_project = "tilecache"
    gemspec.name = "tilecache"
    gemspec.summary = "An implementation of TileCache from MetaCarta, written in pure Ruby"
    #gemspec.description = "An implementation of TileCache from MetaCarta, written in pure Ruby"
    gemspec.email = "pascal.ehlert@odadata.eu"
    gemspec.homepage = "http://github.com/pehlert/ruby-tilecache"
    gemspec.authors = ["Pascal Ehlert"]
    gemspec.files.exclude ".gitignore"
  end
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler not available. Install it with: sudo gem install jeweler"
end

Dir["#{File.dirname(__FILE__)}/tasks/*.rake"].sort.each { |ext| load ext }
