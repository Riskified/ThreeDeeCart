=begin
Configuration object
=end
module ThreeDeeCart
  
  module Exceptions
    class MissingWSDL < RuntimeError; end;
    class MissingConfigurationFile < RuntimeError; end;
  end

	class Config

    @@wsdl = nil
    @@api_key = nil
    
    def self.wsdl
      @@wsdl
    end

    def self.wsdl=(wsdl)
      @@wsdl = wsdl
    end
    
    def self.api_key
      @@api_key || nil
    end

    def self.api_key=(api_key)
      @@api_key = api_key
    end
    
    # Loads configuration from a yml file.
    def self.load_configuration_from_file(yaml_location = "")
      if File.exists?(yaml_location)
        config = YAML::load(File.open(yaml_location))
        self.wsdl = config["wsdl"]
        self.api_key = config["api_key"]
      else
        raise ThreeDeeCart::Exceptions::MissingConfigurationFile, "cannot find #{yaml_location} 3dcart configuration file"
      end

      if self.wsdl.nil?
        raise(ThreeDeeCart::Exceptions::MissingWSDL, "3DCart wsdl url cannot be blank")
      end
      self
    end

    # Loads configuration from a block
    def self.config(&block)
      config = self
      
      yield config

      if config.wsdl.nil?
        raise(ThreeDeeCart::Exceptions::MissingWSDL, "3DCart wsdl url cannot be blank")
      end
      config
    end
  end
end