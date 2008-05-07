$:.unshift(File.dirname(__FILE__)) unless
  $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))

require 'tile_cache/bounds'
require 'tile_cache/tile'
require 'tile_cache/meta_tile'
require 'tile_cache/layer'
require 'tile_cache/meta_layer'
require 'tile_cache/config_parser'
require 'tile_cache/services'
  
module TileCache    
  CONFIG_FILE = File.join(RAILS_ROOT, 'config', 'tilecache.yml')
  SETTINGS = ConfigParser.instance
  
  class InvalidBounds < StandardError; end
  class InvalidResolution < StandardError; end
  class InvalidConfiguration < StandardError; end
  class CacheError < StandardError; end
  class LayerNotFound < StandardError; end
end

