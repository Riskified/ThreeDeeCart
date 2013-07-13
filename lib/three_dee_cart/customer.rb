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
    attr_reader   :billing_address
    attr_reader   :shipping_address
    attr_reader   :comments
    attr_reader   :additional_fields
    
    def self.find(request_options)
      resp = self.request(:get_customer, request_options)
      self.new(resp[:customers_request_response][:customer])
    end

    def billing_address=(value)
      @billing_address = ThreeDeeCart::BillingAddress.new(value) if not value.nil?
    end

    def shipping_address=(value)
      @shipping_address = ThreeDeeCart::ShippingAddress.new(value) if not value.nil?
    end

    def comments=(value)
      @comments = []
      if not value.nil?
        value.each_pair do |key, comment|
          @comments << comment
        end
      end
    end

    def additional_fields=(value)
      @additional_fields = []
      if not value.nil?
        value.each_pair do |key, field|
          @additional_fields << field
        end
      end
    end
  end
end