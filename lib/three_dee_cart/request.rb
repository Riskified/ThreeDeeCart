module ThreeDeeCart
  class Request

    module Exceptions
      class InvalidOperation < ArgumentError; end
      class ResponseError < StandardError; end
      class SoapError < StandardError; end
      class ApiError < StandardError; end
      class HttpError < StandardError; end
    end

    attr_reader :operation
    attr_reader :message
    attr_reader :hash

    def initialize(operation, message = {})
      @operation = operation.downcase.to_sym
      if !(client.operations.include?(@operation))
        raise ThreeDeeCart::Request::Exceptions::InvalidOperation, "#{@operation} is not a valid operation"
      end

      @message = message
      @response = nil
      @hash = {}
    end

    def invoke
      @response = client.call(self.operation, {message: self.message})
      @hash = @response.hash
      if successful?
        @hash
      elsif api_error?
        raise(ThreeDeeCart::Request::Exceptions::ApiError, "Error while calling '#{self.operation}' - #{@response.hash[:error][:description]} (#{@response.hash[:error][:id]})")
      elsif soap_error?
        fault_code = @hash[:envelope][:body][:fault][:faultcode]
        fault_string = @hash[:envelope][:body][:fault][:faultstring].strip
        raise(ThreeDeeCart::Request::Exceptions::SoapError, "Error while calling '#{self.operation} - SOAP error: #{fault_string} (#{fault_code})")
      elsif http_error?
        raise(ThreeDeeCart::Request::Exceptions::HttpError, "An HTTP error occured while trying to call operation '#{self.operation}' - code: #{@response.http.code}")
      end
    end

    protected

    def successful?
      @response && @response.success?
    end

    def http_error?
      @response && @response.http_error?
    end

    def soap_error?
      @response && @response.soap_fault?
    end

    def api_error?
      @response.hash.keys.include?(:error)
    end

    def client
      ThreeDeeCart.client
    end
  end
end