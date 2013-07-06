module ThreeDeeCart
  module Exceptions
    class InvalidAttribute < ArgumentError; end
  end

  class Base < ThreeDeeCart::Root

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