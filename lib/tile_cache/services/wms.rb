module TileCache
  module Services
    class WMS < TileCache::Services::Base
      FIELDS = %{ bbox srs width height format layers styles }
      DEFAULT_PARAMS = {
        :version => '1.1.1',
        :request => 'GetMap',
        :service => 'WMS'
      }
      
      def initialize(params)
        @params = parse_request(params)
      end
      
      def get
        bbox = TileCache::Bounds.from_string(@params[:bbox])
        layer = get_layer(@params[:layers])
        layer.get_tile(bbox)
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