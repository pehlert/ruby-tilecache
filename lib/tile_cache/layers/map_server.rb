module TileCache
  module Layers
    require "mapscript"
    
    class MapServer < TileCache::Layers::MetaBase
      include Mapscript
      
      def initialize(name, config)
        super
        @map = MapObj.new(File.join(RAILS_ROOT, config[:mapfile]))
      end
      
      def render(tile)
        req = build_request(tile)
        
        msIO_installStdoutToBuffer
        @map.OWSDispatch(req)
        msIO_stripStdoutBufferContentType
        msIO_getStdoutBufferBytes
      end
      
    protected
      def build_request(tile)
        req = OWSRequest.new
        
        req.setParameter("bbox", tile.bounds.to_s)
        req.setParameter("width", @size[0].to_s)
        req.setParameter("height", @size[1].to_s)
        req.setParameter("srs", @srs)
        req.setParameter("format", format)
        req.setParameter("layers", @layers)
        req.setParameter("request", "GetMap")
        req.setParameter("service", "WMS")
        req.setParameter("version", "1.1.1")
        
        return req        
      end
    end
  end
end