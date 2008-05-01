module TileCache
  CACHE_ROOT = File.join(RAILS_ROOT, 'tmp', 'mapcache')
  CONFIG_ROOT = File.join(RAILS_ROOT, 'config', 'odamap')
  
  class InvalidBounds < StandardError; end
  class InvalidResolution < StandardError; end
end