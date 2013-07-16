=begin
Represents the a base class that encapsulates the Savon SOAP client integration
=end
module ThreeDeeCart
  module Exceptions
    class InvalidAttribute < ArgumentError; end
    class RequestErrr < StandardError; end
  end

  class Base < ThreeDeeCart::Root
      
    # Build a request and invoke it
    # +method+  - a valid SOAP client operation
    # +message+ - the operation parameters
    def self.request(method, message = {})
      req = ThreeDeeCart::Request.new(method, message)
      req.invoke
    end
  end
end