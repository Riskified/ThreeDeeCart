module ThreeDeeCart
  class Order < ThreeDeeCart::Base
    attr_accessor :order_id
    attr_accessor :invoice_number
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

    def self.find(request_options)
      resp = self.request(:get_order, request_options)
      #raise resp.to_s
      self.new(resp[:get_orders_response][:order])
    end

    def self.count(request_options)
      resp = self.request(:get_order_count, request_options)
      resp[:orders_count_response][:quantity].to_i
    end

    def self.status(request_options)
      resp = self.request(:get_order_status, request_options)
      resp[:order_status_response]
    end

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
          if value[:order_items].class.name != "Hash" || !value[:order_items].keys.include?(:item)
            raise(ThreeDeeCart::Exceptions::InvalidAttributeType, ThreeDeeCart::Exceptions::InvalidAttributeType::DEFAULT_MESSAGE % ["Item", value[:order_items].class])
          end

          item_obj = value[:order_items][:item]
          @order_items = []

          if item_obj.class.name == "Hash"
            @order_items << ThreeDeeCart::Item.new(item_obj)
          elsif item_obj.class.name == "Array"
            if not item_obj.nil?
              item_obj.each do |item_hash|
                @order_items << ThreeDeeCart::Item.new(item_hash)
              end
            end
          else
            raise(ThreeDeeCart::Exceptions::InvalidAttributeType, ThreeDeeCart::Exceptions::InvalidAttributeType::DEFAULT_MESSAGE % ["Item", item_obj.class])
          end
        end
      end
    end
  end
end
