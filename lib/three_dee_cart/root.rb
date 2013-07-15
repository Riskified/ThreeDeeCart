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
      attributes_hash.each_pair do |attr_name, attr_value|
        if self.respond_to?(attr_name)
          self.send("#{attr_name}=", attr_value) 
        else
          raise(ThreeDeeCart::Exceptions::InvalidAttribute, "#{attr_name} is an invalid attribute for #{self.class.name}")
        end
      end
    end
  end
end