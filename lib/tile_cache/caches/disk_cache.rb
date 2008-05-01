module TileCache
  module Caches
    class DiskCache < TileCache::Caches::Base
      require 'ftools'
            
      def initialize(tile)
        @filename = key_for_tile(tile)
        @tile = tile
      end
      
      def get!
        if File.exist?(@filename)
          File.open(@filename, "r") { |f| @tile.data = f.read }          
          return true
        else
          return false
        end
      end
      
      def store!
        File.makedirs(File.dirname(@filename))
        
        File.open(@filename, "wb") do |f|
          f.write(@tile.data)
        end       
      end
      
    protected
      def key_for_tile(tile)
        components = [
          TileCache::CACHE_ROOT,
          tile.layer.name,
          sprintf("%02d", tile.z),
          sprintf("%03d", Integer(tile.x / 1000000)),
          sprintf("%03d", Integer((tile.x / 1000)) % 1000),
          sprintf("%03d", Integer(tile.x) % 1000),
          sprintf("%03d", Integer(tile.y / 1000000)),
          sprintf("%03d", Integer((tile.y / 1000)) % 1000),
          sprintf("%03d.%s", Integer(tile.y) % 1000, tile.layer.extension)
        ]      
        
        File.join(*components)
      end
    end
  end
end