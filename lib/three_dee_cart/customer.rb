=begin
Represents the 3D Cart Customer response object
=end
module ThreeDeeCart
  class Customer < ThreeDeeCart::Base

    attr_accessor :customer_id
    attr_accessor :user_id
    attr_accessor :password
    attr_accessor :last_login_date
    attr_accessor :web_site
    attr_accessor :discount_group
    attr_accessor :cust_other1
    attr_accessor :account_number
    attr_accessor :mail_list
    attr_accessor :customer_type
    attr_accessor :last_update
    attr_accessor :cust_enabled
    attr_accessor :comments
    attr_reader   :billing_address
    attr_reader   :shipping_address
    attr_reader   :additional_fields
    attr_accessor :additional_field4

    # Invoke a :get_customer SOAP operation
    # Request options: 
    # storeURL*       - 3dCart Store URL from which the information will be requested. i.e.: www.3dcart.com
    # batchSize*      - Number of records to pull. Range: 1 to 100.
    # startNum*       - Position to start the search. Range: 1 to x
    # customersFilter - Comma delimited string with zero or more search parameters. Allowed parameters: firstname,
    #                   lastname, email, countrycode, statecode, city, phone.
    #                   i.e.: firstname=John,email=john@email.com, countrycode=US,statecode=FL,city=Margate
    #
    # Returns ThreeDeeCart::Customer instances for each returned value

    def initialize(attributes_hash = {})
      super
      @additional_fields << self.additional_field4
      @additional_fields = @additional_fields.compact
    end

    def self.find(request_options)
      resp = self.request(:get_customer, request_options)
      resp_obj = resp[:get_customer_response][:get_customer_result][:customers_request_response][:customer]
      if resp_obj.is_a?(Hash)
        self.new(resp_obj)
      else
        customer_arr = []
        resp_obj.each do |resp_hash|
          customer_arr << self.new(resp_hash)
        end

        customer_arr
      end
    end

    # Invoke :get_customer_count SOAP operation
    # Request Options:
    # storeURL*       - 3dCart Store URL from which the information will be requested. i.e.: www.3dcart.com
    # 
    # Returns total customer count for the store
    def self.count(request_options)
      resp = self.request(:get_customer_count, request_options)
      resp[:get_customer_count_response][:get_customer_count_result][:customer_count_response][:customer_count].to_i
    end

    # Invoke :edit_customer SOAP operation
    # customer_data   - customer data initialized with one of the valid actions [:insert, :update, :delete] and hash of attributes
    # Request Options:
    # storeURL*       - 3dCart Store URL from which the information will be requested. i.e.: www.3dcart.com
    # 
    # Returns total customer count for the store
    def self.edit(customer_data, request_options = {})
      if customer_data.nil? || !customer_data.valid?
        return false
      end

      resp = self.request(:edit_customer, request_options.merge(:customerData => customer_data.to_query, :action => customer_data.action))
      resp[:edit_customer_response][:edit_customer_result][:edit_customer_response][:result] == "OK"
    end

    # Custom setter for billing address, creates a ThreeDeeCart::BillingAddress instance
    def billing_address=(value)
      if value.class.name != "Hash"
        raise(ThreeDeeCart::Exceptions::InvalidAttributeType, ThreeDeeCart::Exceptions::InvalidAttributeType::DEFAULT_MESSAGE % ["Billing Address", value.class])
      end

      @billing_address = ThreeDeeCart::BillingAddress.new(value) if not value.nil?
    end

    # Custom setter for shipping address, creates a ThreeDeeCart::ShippingAddress instance
    def shipping_address=(value)
      if value.class.name != "Hash"
        raise(ThreeDeeCart::Exceptions::InvalidAttributeType, ThreeDeeCart::Exceptions::InvalidAttributeType::DEFAULT_MESSAGE % ["Shipping Address", value.class])
      end

      @shipping_address = ThreeDeeCart::ShippingAddress.new(value) if not value.nil?
    end

    # Custom setter for additional fields, error in spelling is in purpose - api returns it like this.
    def aditional_fields=(value)
      if value.class.name != "Hash"
        raise(ThreeDeeCart::Exceptions::InvalidAttributeType, ThreeDeeCart::Exceptions::InvalidAttributeType::DEFAULT_MESSAGE % ["Additional Fields", value.class])
      end

      if not value.nil?
        @additional_fields = value.values
      end

      @additional_fields
    end
  end
end