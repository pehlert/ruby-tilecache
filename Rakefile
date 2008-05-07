# Look in the tasks/setup.rb file for the various options that can be
# configured in this Rakefile. The .rake files in the tasks directory
# are where the options are used.

load 'tasks/setup.rb'

ensure_in_path 'lib'
require 'tile_cache/version.rb'

task :default => 'spec:run'

PROJ.name = 'ruby-tilecache'
PROJ.authors = 'Pascal Ehlert, ODAdata'
PROJ.email = 'pascal.ehlert@odadata.eu'
PROJ.url = 'http://ruby-tilecache.rubyforge.org'
PROJ.rubyforge.name = 'ruby-tilecache'
PROJ.version = TileCache::VERSION::STRING
PROJ.spec.opts << '--color'

PROJ.gem.dependencies = ['activesupport'] 

# EOF
