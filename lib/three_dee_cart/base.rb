module ThreeDeeCart
  module Exceptions
    class InvalidAttribute < ArgumentError; end
  end

  class Base < ThreeDeeCart::Root

    def self.client
      ThreeDeeCart.client
    end

    def self.mapping(method_name, operation)

      self.class_eval do
        define_singleton_method(method_name) do |request_options|
          self.client.call(operation.to_sym, request_options)
        end
      end
    end
  end
end