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

    def self.mapping(method_name, operation, options = {})

      self.class_eval do
        define_singleton_method(method_name) do |options|
          self.client.call(operation.to_sym, options)
        end
      end
    end
  end
end