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
    
    def self.find(request_options)
      resp = self.request(:get_customer, request_options)

      resp_obj = resp[:customers_request_response][:customer]
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

    def self.count(request_options)
      resp = self.request(:get_customer_count, request_options)
      resp[:customer_count_response][:customer_count].to_i
    end

    def billing_address=(value)
      if value.class.name != "Hash"
        raise(ThreeDeeCart::Exceptions::InvalidAttributeType, ThreeDeeCart::Exceptions::InvalidAttributeType::DEFAULT_MESSAGE % ["Billing Address", value.class])
      end

      @billing_address = ThreeDeeCart::BillingAddress.new(value) if not value.nil?
    end

    def shipping_address=(value)
      if value.class.name != "Hash"
        raise(ThreeDeeCart::Exceptions::InvalidAttributeType, ThreeDeeCart::Exceptions::InvalidAttributeType::DEFAULT_MESSAGE % ["Shipping Address", value.class])
      end

      @shipping_address = ThreeDeeCart::ShippingAddress.new(value) if not value.nil?
    end

    def additional_fields=(value)
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