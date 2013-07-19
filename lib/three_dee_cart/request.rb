=begin
A wrapper for Savon::Client
=end
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
    attr_reader :response
    attr_reader :error

    # Initialize a new request, check if the requested operation exists in the SOAP client schema
    def initialize(operation, message = {})
      @operation = operation.downcase.to_sym
      if !(client.operations.include?(@operation))
        raise ThreeDeeCart::Request::Exceptions::InvalidOperation, "#{@operation} is not a valid operation"
      end

      @message = message
      @response = nil
      @hash = {}
    end

    # Run the request
    def invoke
      
      @response = client.call(self.operation, {message: self.message.merge(userKey: ThreeDeeCart.configuration.api_key)})
      @hash = @response.hash[:envelope][:body]
      # Return the hash if successful
      if api_error? # Return a human readable error for API error
        if @error.is_a?(String)
          raise(ThreeDeeCart::Request::Exceptions::ApiError, "Error while calling '#{self.operation} - #{@error}'")
        elsif @error.is_a?(Hash)
          raise(ThreeDeeCart::Request::Exceptions::ApiError, "Error while calling '#{self.operation}' - #{@error[:description]} (#{@error[:id]})")
        end
      elsif soap_error? # Return a human readable error for SOAP error
        fault_code = @hash[:fault][:faultcode]
        fault_string = @hash[:fault][:faultstring].strip
        raise(ThreeDeeCart::Request::Exceptions::SoapError, "Error while calling '#{self.operation} - SOAP error: #{fault_string} (#{fault_code})")
      elsif http_error? # Return a human readable error for HTTP error response
        raise(ThreeDeeCart::Request::Exceptions::HttpError, "An HTTP error occured while trying to call operation '#{self.operation}' - code: #{@response.http.code}")
      elsif successful?
        @hash
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
      @error = @response.hash.deep_find(:error)
      @error.nil? == false
    end

    # Proxy to the ThreeDeeCart client
    def client
      ThreeDeeCart.client
    end
  end
end