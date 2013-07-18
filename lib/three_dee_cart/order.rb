=begin
Represents the 3D Cart Order response object
=end
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
    attr_accessor :card_type
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
    attr_accessor :checkout_questions

    attr_reader :transaction
    attr_reader :billing_address
    attr_reader :comments
    attr_reader :affiliate_information
    attr_reader :shipment
    attr_reader :order_items

    # Invokes :get_order SOAP operation
    # Request options:
    # storeURL*       - 3dCart Store URL from which the information will be requested. i.e.: www.3dcart.com
    # batchSize*      - Number of records to pull. Range: 1 to 100.
    # startNum*       - Position to start the search. Range: 1 to x
    # startFrom*      - boolean, If startFrom is true and invoiceNum is specified, the web service will return orders >= invoiceNum.
    #                   If startFrom is false and invoiceNum is specified, the web service will return just the specified order.
    #                   If invoiceNum is not specified, this parameter will be ignored.
    # invoiceNum      - Search for specific invoice number.
    # status          - Search orders by status.
    # dateFrom        - Search orders that were placed after specified date. Must be in mm/dd/yyyy format.
    # dateTo          - Search orders that were placed before specified date. Must be in mm/dd/yyyy format.
    #
    # Returns ThreeDeeCart::Order for each returned order
    def self.find(request_options)
      resp = self.request(:get_order, request_options)

      resp_obj = resp[:get_order_response][:get_order_result][:get_orders_response][:order]
      if resp_obj.is_a?(Hash)
        self.new(resp_obj)
      else
        order_arr = []
        resp_obj.each do |resp_hash|
          order_arr << self.new(resp_hash)
        end

        order_arr
      end
    end

    # Invokes :get_order_count SOAP operation
    # storeURL*       - 3dCart Store URL from which the information will be requested. i.e.: www.3dcart.com
    # startFrom*      - boolean, If startFrom is true and invoiceNum is specified, the web service will return orders >= invoiceNum.
    #                   If startFrom is false and invoiceNum is specified, the web service will return just the specified order.
    #                   If invoiceNum is not specified, this parameter will be ignored.
    # invoiceNum      - Search for specific invoice number.
    # status          - Search orders by status.
    # dateFrom        - Search orders that were placed after specified date. Must be in mm/dd/yyyy format.
    # dateTo          - Search orders that were placed before specified date. Must be in mm/dd/yyyy format.
    #
    # Returns a quantity sum of all the matching orders
    def self.count(request_options)
      resp = self.request(:get_order_count, request_options)
      resp[:get_order_count_response][:get_order_count_result][:orders_count_response][:quantity].to_i
    end

    # Invokes :get_order_status SOAP operation
    # Request options:
    # storeURL*        - 3dCart Store URL from which the information will be requested. i.e.: www.3dcart.com
    # invoiceNum*      - Search for specific invoice number.
    # 
    # Returns a hash with the status code and text. i.e: {:status_id => 1, :status_text => "New"}
    def self.status(request_options)
      resp = self.request(:get_order_status, request_options)
      resp[:get_order_status_response][:get_order_status_result][:order_status_response]
    end

    # Invokes :update_order_status SOAP operation
    # Request options:
    # storeURL*        - 3dCart Store URL from which the information will be requested. i.e.: www.3dcart.com
    # invoiceNum*      - Search for specific invoice number.
    # newStatus*       - string, New status for the specified order.
    #
    # returns a hash with the invoice number and new status. i.e: {invoice_num: "1476", new_status: "New"}
    def self.update_status(request_options)
      resp = self.request(:update_order_status, request_options)
      resp[:update_order_status_response][:update_order_status_result][:update_order_status_response]
    end

    # Invokes :update_order_shipment SOAP operation
    # storeURL*        - 3dCart Store URL from which the information will be requested. i.e.: www.3dcart.com
    # invoiceNum*      - Search for specific invoice number.
    # shipmentID       - numeric, dentifies the shipment id for multiple shipment orders. 
    #                    This ID can be found on the response of the getOrder method.
    # tracking*        - Tracking code of the specified order/shipment.
    # shipmentDate*    - Shipping date of the specified order/shipment.
    #
    # Returns a true / false response to indicate success
    def self.update_shipment(request_options)
      resp = self.request(:update_order_shipment, request_options)
      resp[:update_order_shipment_response][:update_order_shipment_result][:update_order_shipment_response][:result] == "OK"
    end

    # Custom setter for billing address, returns ThreeDeeCart::BillingAddress
    def billing_address=(value)
      @billing_address = ThreeDeeCart::BillingAddress.new(value) if not value.nil?
    end

    # Custom setter for transaction, returns ThreeDeeCart::Transaction
    def transaction=(value)
      @transaction = ThreeDeeCart::Transaction.new(value) if not value.nil?
    end

    # Custom setter for comments
    def comments=(value)
      @comments = []
      if not value.nil?
        value.each_pair do |key, comment|
          @comments << comment
        end
      end
    end

    # Custom setter for affiliate information, returns ThreeDeeCart::AffiliateInformation
    def affiliate_information=(value)
      @shipping_address = ThreeDeeCart::AffiliateInformation.new(value) if not value.nil?
    end

    # Custom setter for shipping information, returns ThreeDeeCart::Shipment and ThreeDeeCart::Item for order items
    def shipping_information=(value)
      if not value.nil?
        @shipment = ThreeDeeCart::Shipment.new(value[:shipment])
        if not value[:order_items].nil?
          if value[:order_items].class.name != "Hash" || !value[:order_items].keys.include?(:item)
            raise(ThreeDeeCart::Exceptions::InvalidAttributeType, ThreeDeeCart::Exceptions::InvalidAttributeType::DEFAULT_MESSAGE % ["Item", value[:order_items].class])
          end

          item_obj = value[:order_items][:item]
          @order_items = []

          if item_obj.is_a?(Hash)
            @order_items << ThreeDeeCart::Item.new(item_obj)
          elsif item_obj.is_a?(Array)
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
