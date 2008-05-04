module TileCache
  module Caches
    class DiskCache
      def initialize(tile)
        @filename = key_for_tile(tile)
        @tile = tile
      end
      
      def get!
        if File.exist?(@filename)
          File.open(@filename, File::RDONLY) { |f| @tile.data = f.read }          
          return true
        else
          return false
        end
      end
      
      def store!(data = nil)
        @tile.data = data if data
        
        if @tile.data
          # Create the full path to the cache file
          FileUtils.mkdir_p(File.dirname(@filename))
          
          File.open(@filename, (File::WRONLY | File::CREAT)) do |f|
            f.sync = true
            f.write(@tile.data)
          end    
        else
          raise TileCache::CacheError, "Called #store! with no data argument and no data associated with the tile."   
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