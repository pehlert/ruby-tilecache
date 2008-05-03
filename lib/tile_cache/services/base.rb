module TileCache
  module Services
    class Base
      # Returns new instance of the layer with a given name.
      # Raises TileCache::LayerNotFound if there is no such layer in the configuration file.
      def get_layer(name)
        config = configuration_for_layer(name)
        
        if config.nil? 
          raise TileCache::LayerNotFound, "No configuration found for layer: #{name}"
        elsif config[:type].nil? 
          raise TileCache::InvalidConfiguration, "Missing type attribute for layer: #{name}"
        else
          klass = layer_class_for_type(config[:type])
          klass.new(name, config)
        end
      end
      
    private
      # Returns the configuration hash for a given layer or raises an 
      # TileCache::InvalidConfiguration error if configuration does not exist
      def configuration_for_layer(name)
        filename = File.join(TileCache::CONFIG_ROOT, 'layers.yml')
  
        if File.exist?(filename)
          config = YAML.load(File.read(filename))
        else
          raise TileCache::InvalidConfiguration, "Layers configuration file not found: #{filename}"
        end  
        
        if config[name.to_s]
          layer_config = config[name.to_s].symbolize_keys
          layer_config.reverse_merge(TileCache::DEFAULT_LAYER_CONFIGURATION).with_indifferent_access
        end
      end
      
      # Get layer class from TileCache::Layers for the specified type,
      # raises TileCache::InvalidConfiguration if no class has been found
      def layer_class_for_type(type)
        class_name = type.gsub("Layer", "")
        
        begin
          TileCache::Layers.const_get(class_name)
        rescue NameError
          raise TileCache::InvalidConfiguration, "Invalid type attribute: #{type}"
        end
      end
    end
  end
end