module ThreeDeeCart
  class Order < ThreeDeeCart::Base
    attr_accessor :order_id
    attr_accessor :customer_id
    attr_accessor :user_id
    attr_accessor :date
    attr_accessor :date_started
    attr_accessor :last_update
    attr_accessor :total
    attr_accessor :tax
    attr_accessor :tax2
    attr_accessor :tax3
    attr_accessor :payment_method
    attr_accessor :time
    attr_accessor :shipping
    attr_accessor :discount
    attr_accessor :promotions
    attr_accessor :gift_certificate_purchased
    attr_accessor :gift_certificate_used
    attr_accessor :order_status
    attr_accessor :sales_person
    attr_accessor :ip
    attr_accessor :referer
    attr_accessor :weight

    attr_reader :transaction
    attr_reader :billing_address
    attr_reader :comments
    attr_reader :affiliate_information
    attr_reader :shipment
    attr_reader :order_items

    def billing_address=(value)
      @billing_address = ThreeDeeCart::BillingAddress.new(value) if not value.nil?
    end

    def transaction=(value)
      @transaction = ThreeDeeCart::Transaction.new(value) if not value.nil?
    end

    def comments=(value)
      @comments = []
      if not value.nil?
        value.each_pair do |key, comment|
          @comments << comment
        end
      end
    end

    def affiliate_information=(value)
      @shipping_address = ThreeDeeCart::AffiliateInformation.new(value) if not value.nil?
    end

    def shipping_information=(value)
      if not value.nil?
        @shipment = ThreeDeeCart::Shipment.new(value[:shipment])
        if not value[:order_items].nil?
          @order_items = []
          value[:order_items].each_pair do |key, item_hash|
            @order_items << ThreeDeeCart::Item.new(item_hash)
          end
        end
      end
    end
  end
end
