=begin
Root class to allow attributes collection and a custom initialized to set all instance variables from a hash
=end
module ThreeDeeCart
  module Exceptions
    class InvalidAttribute < ArgumentError; end
    class InvalidAttributeType < ArgumentError 
      DEFAULT_MESSAGE = "%s has an invalid attribute type %s"
    end
  end

  class Root
    # Assign attributes from incoming hash
    def initialize(attributes_hash = {})
      @attributes = {}

      # Assign incoming hash value to a matching local instance variable, if exists
      attributes_hash.each_pair do |attr_name, attr_value|
        if self.respond_to?("#{attr_name}=")
          self.send("#{attr_name}=", attr_value) 
        else
          raise(ThreeDeeCart::Exceptions::InvalidAttribute, "#{attr_name} is an invalid attribute for #{self.class.name}")
        end
      end
    end

    # Custom attribute accessor that also maintains an #attributes hash for later access
    def self.attribute_accessor(*names)
      names.to_a.each do |accessor_name|
        define_method("#{accessor_name}=") do |new_val|
          instance_variable_set("@#{accessor_name}", new_val)
          @attributes[accessor_name.to_sym] = new_val
        end

        define_method(accessor_name) do
          instance_variable_get("@#{accessor_name}")
        end
      end
    end

    # Attributes hash getter
    def attributes
      @attributes
    end
  end
end