module TileCache
  module Layers
    DEFAULT_CONFIG = {
      :bbox => [-180, -90, 180, 90],
      :srs => "EPSG:4326",
      :description => "",
      :size => [256, 256],
      :levels => 20,
      :extension => "png"
    }
    
    class LayerNotFound < StandardError; end
    class InvalidConfiguration < StandardError; end
  end
end