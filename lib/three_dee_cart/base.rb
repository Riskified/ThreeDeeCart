module ThreeDeeCart

  module Exceptions
    class InvalidAttribute < ArgumentError; end
  end

  class Base

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

    def self.client
      ThreeDeeCart.client
    end
  end
end