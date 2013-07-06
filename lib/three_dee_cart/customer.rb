module ThreeDeeCart
  class Customer < ThreeDeeCart::Base

    mapping :find, :get_customer

    attr_accessor :customer_id
    attr_accessor :user_id
    attr_reader   :billing_address
    attr_reader   :shipping_address
    attr_reader   :comments
    attr_accessor :last_login_date
    attr_accessor :website
    attr_accessor :discount_group
    attr_accessor :cust_other1
    attr_accessor :account_number
    attr_accessor :mail_list
    attr_accessor :customer_type
    attr_accessor :last_update
    attr_accessor :cust_enabled
    attr_reader   :additional_fields
    
    def billing_address=(value)
      @billing_address = ThreeDeeCart::BillingAddress.new(value)
    end

    def shipping_address=(value)
      @shipping_address = ThreeDeeCart::ShippingAddress.new(value)
    end

    def comments=(value)
      @comments = []
      value.each_pair do |key, comment|
        @comments << comment
      end
    end

    def additional_fields=(value)
      @additional_fields = []
      value.each_pair do |key, field|
        @additional_fields << field
      end
    end
  end
end