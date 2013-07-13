module ThreeDeeCart
  
  module Exceptions
    class MissingApiKey < RuntimeError; end;
    class MissingConfigurationFile < RuntimeError; end;
  end

	class Config

    def self.wsdl
      @@wsdl
    end

    def self.wsdl=(wsdl)
      @@wsdl = wsdl
    end
    
    def self.api_key
      @@api_key
    end

    def self.api_key=(api_key)
      @@api_key = api_key
    end
    
    def self.load_configuration_from_file(yaml_location = "")
      if File.exists?(yaml_location)
        config = YAML::load(File.open(yaml_location))
        self.wsdl = config["wsdl"]
        self.api_key = config["api_key"]
      else
        raise ThreeDeeCart::Exceptions::MissingConfigurationFile, "cannot find #{yaml_location} 3dcart configuration file"
      end

      if self.api_key.blank?
        raise(ThreeDeeCart::Exceptions::MissingApiKey, "3DCart API Key cannot be blank")
      end
      self
    end

    def self.config(&block)
      config = self
      
      yield config

      if config.api_key.blank?
        raise(ThreeDeeCart::Exceptions::MissingApiKey, "3DCart API Key cannot be blank")
      end
      config
    end
  end
end