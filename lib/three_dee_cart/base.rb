module ThreeDeeCart
  module Exceptions
    class InvalidAttribute < ArgumentError; end
    class RequestErrr < StandardError; end
  end

  class Base < ThreeDeeCart::Root
    
    def self.request(method, message = {})
      req = ThreeDeeCart::Request.new(method, message)
      req.invoke
    end
  end
end