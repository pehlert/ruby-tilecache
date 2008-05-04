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