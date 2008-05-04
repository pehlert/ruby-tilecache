module TileCache
  module Services
    class WMS
      FIELDS = %{ bbox srs width height format layers styles }
      
      def initialize(params)
        @params = parse_request(params)
      end
      
      def get_map
        bbox = TileCache::Bounds.from_string(@params[:bbox])
        TileCache::LayersPool.get(@params[:layers])
      end
      
    private
      def parse_request(params)
        params.inject({}) do |parsed, (k, v)|
          key = k.downcase
          if FIELDS.include?(key)
            parsed[key.to_sym] = v
          end
          
          parsed
        end
      end
    end
  end
end