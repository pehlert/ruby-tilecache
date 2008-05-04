require 'tile_cache/bounds'

require 'tile_cache/layers_pool'
require 'tile_cache/layer'
require 'tile_cache/meta_layer'

require 'tile_cache/tile'
require 'tile_cache/meta_tile'

require 'tile_cache/layers/map_server'

require 'tile_cache/caches/disk_cache'

require 'tile_cache/services/wms'

module TileCache
  CACHE_ROOT = File.join(RAILS_ROOT, 'tmp', 'mapcache')
  CONFIG_ROOT = File.join(RAILS_ROOT, 'config', 'tilecache')
  
  DEFAULT_LAYER_CONFIGURATION = {
    :bbox => [-180, -90, 180, 90],
    :srs => "EPSG:4326",
    :description => "",
    :size => [256, 256],
    :levels => 20,
    :extension => "png",
    :metatile => false,
    :metasize => [5, 5],
    :metabuffer => [10, 10]
  }
  
  class InvalidBounds < StandardError; end
  class InvalidResolution < StandardError; end
  class InvalidConfiguration < StandardError; end
  class CacheError < StandardError; end
  class LayerNotFound < StandardError; end
end