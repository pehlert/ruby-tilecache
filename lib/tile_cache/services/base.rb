module TileCache
  module Services
    class Base

    protected
      def get_layer(name)
        config_file = File.join(TileCache::CONFIG_ROOT, 'layers.yml')
        config = YAML.load(File.read(config_file))[name]

        unless config
          raise TileCache::Layers::LayerNotFound, "No configuration found for layer #{name}"
        end
        
        config = HashWithIndifferentAccess.new(config)
        config.reverse_merge!(TileCache::Layers::DEFAULT_CONFIG)

        unless config[:type] 
          raise TileCache::Layers::InvalidConfiguration, "Missing type attribute for layer #{name}" 
        end

        unless layer = TileCache::const_get("Layers").const_get(config[:type])
          raise TileCache::Layers::InvalidConfiguration, "Invalid type attribute for layer #{name}: #{config[:type]}" 
        end

        return layer.new(name, config)
      end
    end
  end
end