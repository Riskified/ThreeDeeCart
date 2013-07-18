=begin
Represents the 3D Cart Product response object
=end
module ThreeDeeCart
  class Product < ThreeDeeCart::Base
    attr_accessor :product_id
    attr_accessor :product_name
    attr_accessor :mfgid
    attr_accessor :manufacturer
    attr_accessor :distributor
    attr_accessor :cost
    attr_accessor :price
    attr_accessor :retail_price
    attr_accessor :sale_price
    attr_accessor :on_sale
    attr_accessor :stock
    attr_accessor :stock_alert
    attr_accessor :weight
    attr_accessor :width
    attr_accessor :height
    attr_accessor :depth
    attr_accessor :minimum_order
    attr_accessor :maximum_order
    attr_accessor :date_created
    attr_accessor :description
    attr_accessor :extended_description
    attr_accessor :ship_cost
    attr_accessor :title
    attr_accessor :display_text
    attr_accessor :home_special
    attr_accessor :category_special
    attr_accessor :hide
    attr_accessor :free_shipping
    attr_accessor :non_tax
    attr_accessor :not_forsale
    attr_accessor :gift_certificate
    attr_accessor :user_id
    attr_accessor :last_update
    attr_accessor :min_order
    attr_accessor :listing_display_type
    attr_accessor :show_out_stock
    attr_accessor :pricing_group_opt
    attr_accessor :quantity_discount_opt
    attr_accessor :login_level
    attr_accessor :redirect_to
    attr_accessor :access_group
    attr_accessor :self_ship
    attr_accessor :tax_code
    attr_accessor :non_searchable
    attr_accessor :instock_message
    attr_accessor :out_of_stock_message
    attr_accessor :back_order_message
    attr_accessor :thumbnail
    attr_accessor :file_name
    attr_accessor :use_catoptions
    attr_accessor :quantity_options
    attr_accessor :catalog_id
    attr_accessor :warehouse_location
    attr_accessor :warehouse_bin
    attr_accessor :warehouse_aisle
    attr_accessor :warehouse_custom
    attr_accessor :review_average
    attr_accessor :review_count

    attr_reader :categories
    attr_reader :extra_fields
    attr_reader :price_level
    attr_reader :e_product
    attr_reader :rewards
    attr_reader :images
    attr_reader :options
    attr_reader :keywords

    # not sure what this is yet
    attr_accessor :related_products
    attr_accessor :meta_tags

    # Invokes the :get_product SOAP operation
    # Request options:
    # storeURL*       - 3dCart Store URL from which the information will be requested. i.e.: www.3dcart.com
    # batchSize*      - Number of records to pull. Range: 1 to 100.
    # startNum*       - Position to start the search. Range: 1 to x
    # productId       - Search for specific product id.
    #
    # Returns a ThreeDeeCart::Product for each returned product
    def self.find(request_options)
      resp = self.request(:get_product, request_options)
      
      resp_obj = resp[:get_product_response][:get_product_result][:get_product_details_response][:product]
      if resp_obj.is_a?(Hash)
        self.new(resp_obj)
      else
        product_arr = []
        resp_obj.each do |resp_hash|
          product_arr << self.new(resp_hash)
        end

        product_arr
      end
    end

    # Invokes the :get_product_count SOAP operation
    # Request options:
    # storeURL*       - 3dCart Store URL from which the information will be requested. i.e.: www.3dcart.com
    #
    # Returns total product count for the store
    def self.count(request_options)
      resp = self.request(:get_product_count, request_options)
      resp[:get_product_count_response][:get_product_count_result][:get_product_count_response][:product_quantity].to_i
    end

    # Invokes the :get_product_inventory SOAP operation
    # Request options:
    # storeURL*       - 3dCart Store URL from which the information will be requested. i.e.: www.3dcart.com
    # productId*      - Search for specific product id.
    #
    # Returns total inventory quantity for the product specified
    def self.inventory_count(request_options)
      resp = self.request(:get_product_inventory, request_options)
      resp[:get_product_inventory_response][:get_product_inventory_result][:get_inventory_response][:inventory].to_i
    end

    # Invokes the :update_product_inventory SOAP operation
    # Request options:
    # storeURL*       - 3dCart Store URL from which the information will be requested. i.e.: www.3dcart.com
    # productId*      - Search for specific product id.
    # quantity*       - Stock quantity for the specified product.
    # replaceStock*   - boolean, Indicates if the stock should be replaced or
    #                   incremented by the new quantity.
    #
    # Returns total inventory quantity for the product specified
    def self.update_inventory(request_options)
      resp = self.request(:update_product_inventory, request_options)
      resp[:update_inventory_response][:new_inventory].to_i
    end

    # Custom setter for e_product, returns ThreeDeeCart::EProduct
    def e_product=(value)
      if value.class.name != "Hash"
        raise(ThreeDeeCart::Exceptions::InvalidAttributeType, ThreeDeeCart::Exceptions::InvalidAttributeType::DEFAULT_MESSAGE % ["EProduct", value.class])
      end

      @e_product = ThreeDeeCart::EProduct.new(value) if not value.nil?
    end

    # Custom setter for rewards, returns ThreeDeeCart::Rewards
    def rewards=(value)
      if value.class.name != "Hash"
        raise(ThreeDeeCart::Exceptions::InvalidAttributeType, ThreeDeeCart::Exceptions::InvalidAttributeType::DEFAULT_MESSAGE % ["Rewards", value.class])
      end

      @rewards = ThreeDeeCart::Rewards.new(value) if not value.nil?
    end
    
    # Custom setter for categories, returns ThreeDeeCart::Category
    def categories=(value)

      if value.class.name != "Hash" || !value.keys.include?(:category)
        raise(ThreeDeeCart::Exceptions::InvalidAttributeType, ThreeDeeCart::Exceptions::InvalidAttributeType::DEFAULT_MESSAGE % ["Categories", value.class])
      end

      value_category = value[:category]
      @categories = []
      if value_category.is_a?(Array)
        if not value_category.nil?
          value_category.each do |category|
            @categories << ThreeDeeCart::Category.new(category)
          end
        end
      elsif value_category.is_a?(Hash)
        @categories << ThreeDeeCart::Category.new(value_category)
      else
        raise(ThreeDeeCart::Exceptions::InvalidAttributeType, ThreeDeeCart::Exceptions::InvalidAttributeType::DEFAULT_MESSAGE % ["Categories", value_category.class])
      end

      @categories
    end

    # Custom setter for extra_fields
    def extra_fields=(value)
      
      if value.class.name != "Hash"
        raise(ThreeDeeCart::Exceptions::InvalidAttributeType, ThreeDeeCart::Exceptions::InvalidAttributeType::DEFAULT_MESSAGE % ["Extra fields", value.class])
      end

      if not value.nil?
        @extra_fields = value.values
      end

      @extra_fields = @extra_fields.compact
    end

    # Custom setter for price_level
    def price_level=(value)
      if value.class.name != "Hash"
        raise(ThreeDeeCart::Exceptions::InvalidAttributeType, ThreeDeeCart::Exceptions::InvalidAttributeType::DEFAULT_MESSAGE % ["Price Levels", value.class])
      end

      if not value.nil?
        @price_levels = value.values
      end

      @price_levels
    end

    # Custom setter for images, returns ThreeDeeCart::Image
    def images=(value)
      if value.class.name != "Hash"
        raise(ThreeDeeCart::Exceptions::InvalidAttributeType, ThreeDeeCart::Exceptions::InvalidAttributeType::DEFAULT_MESSAGE % ["Images3", value.class])
      end

      value_images = value[:image]

      if value_images.class.name != "Array"
        raise(ThreeDeeCart::Exceptions::InvalidAttributeType, ThreeDeeCart::Exceptions::InvalidAttributeType::DEFAULT_MESSAGE % ["Images2", value_images.class])
      end

      @images = []
      if not value_images.nil?
        value_images.each do |category|
          @images << ThreeDeeCart::Image.new(category)
        end
      end

      @images
    end

    # Custom setter for options, returns ThreeDeeCart::Option    
    def options=(value)
      return if value.nil?
      if value.class.name != "Hash" || !value.keys.include?(:option)
        raise(ThreeDeeCart::Exceptions::InvalidAttributeType, ThreeDeeCart::Exceptions::InvalidAttributeType::DEFAULT_MESSAGE % ["Options", value.class])
      end

      value_options = value[:option]

      if value_options.class.name != "Array"
        raise(ThreeDeeCart::Exceptions::InvalidAttributeType, ThreeDeeCart::Exceptions::InvalidAttributeType::DEFAULT_MESSAGE % ["Options", value_options.class])
      end

      @options = []
      if not value_options.nil?
        value_options.each do |option|
          @options << ThreeDeeCart::Option.new(option)
        end
      end

      @options
    end

    # Custom setter for keywords, broken by comma.
    def keywords=(value)
      @keywords = value.to_s.split(',')
    end
  end
end
