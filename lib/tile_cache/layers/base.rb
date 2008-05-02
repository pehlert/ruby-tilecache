module TileCache
  module Layers
    class Base
      attr_reader :name, :config, :description, :layers, :bbox, :size, :units, :srs, :extension, :resolutions
      
      def initialize(name, config)
        @config = config
                
        @name = name
        @description = config[:description]
        @layers = config[:layers] || name
        @bbox = config[:bbox].is_a?(String) ? TileCache::Bounds.from_string(config[:bbox]) : TileCache::Bounds.new(*config[:bbox])
        @size = config[:size].is_a?(String) ? config[:size].split(",").map { |s| Integer(s.strip) } : config[:size].map { |s| s.to_i }
        @units = config[:units]
        @srs = config[:srs]
        
        @extension = config[:extension].downcase
        @extension = 'jpeg' if @extension == 'jpg'
        
        @cache = config[:cache]
        
        @resolutions = parse_resolutions(config[:resolutions], config[:maxresolution])
      end
      
      def get_tile(bbox)
        coords = get_cell(bbox)
        tile = TileCache::Tile.new(self, *coords)        
        cache = TileCache::Caches::DiskCache.new(tile)
        
        unless cache.get!
          data = render(tile)
          cache.store!(data)
        end
        
        return tile
      end
      
      def format
        return "image/" + @extension
      end
      
    protected
      # Returns the z-index the bboxes resolution
      def level_for_bbox(bbox)
        max_diff = bbox.resolution / @size.max
        
        if match = @resolutions.detect { |res| (res - bbox.resolution).abs < max_diff }
          @resolutions.index(match)
        else
          raise TileCache::InvalidResolution, "Can't find resolution index for #{bbox.resolution}. Available resolutions are #{@resolutions.join(', ')}."
        end
      end
      
      # Returns x, y and z coordinates for a given bbox
      def get_cell(bbox)
        # Get exact resolution as specified
        z = level_for_bbox(bbox)
        res = @resolutions[z]
        
        x = ((bbox.minx - @bbox.minx) / (res * @size[0])).round
        y = ((bbox.miny - @bbox.miny) / (res * @size[1])).round
        
        return [x, y, z]
      end
      
    private
      # Calculate resolutions unless given via configuration
      def parse_resolutions(resolutions, max_resolution)
        case resolutions
        when String
          @config[:resolutions].split(",").map { |r| Float(r.strip) }
        when Array
          @config[:resolutions].map { |r| Float(r) }
        when NilClass
          max_res = max_resolution.nil? ? @bbox.max_resolution(*@size) : max_resolution.to_f
          (1..@config[:levels]).map { |i| max_res / 2 ** i }
        else
          raise TileCache::Layers::InvalidConfiguration, "Invalid format of resolutions for layer #{@name}"
        end
      end
      
    end
  end
end