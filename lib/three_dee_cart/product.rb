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
    attr_accessor :date_create
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
    attr_accessor :not_for_sale
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

    attr_reader :categories
    attr_reader :extra_fields
    attr_reader :price_levels
    attr_reader :e_product
    attr_reader :rewards
    attr_reader :images
    attr_reader :options
    attr_reader :keywords

    # not sure what this is yet
    attr_accessor :related_products
    attr_accessor :meta_tags

    def e_product=(value)
      if value.class.name != "Hash"
        raise(ThreeDeeCart::Exceptions::InvalidAttributeType, ThreeDeeCart::Exceptions::InvalidAttributeType::DEFAULT_MESSAGE % ["EProduct", value.class])
      end

      @e_product = ThreeDeeCart::EProduct.new(value) if not value.nil?
    end

    def rewards=(value)
      if value.class.name != "Hash"
        raise(ThreeDeeCart::Exceptions::InvalidAttributeType, ThreeDeeCart::Exceptions::InvalidAttributeType::DEFAULT_MESSAGE % ["Rewards", value.class])
      end

      @rewards = ThreeDeeCart::Rewards.new(value) if not value.nil?
    end
    
    def categories=(value)
      if value.class.name != "Array"
        raise(ThreeDeeCart::Exceptions::InvalidAttributeType, ThreeDeeCart::Exceptions::InvalidAttributeType::DEFAULT_MESSAGE % ["Categories", value.class])
      end

      @categories = []
      if not value.nil?
        value.each do |category|
          @categories << ThreeDeeCart::Category.new(category)
        end
      end

      @categories
    end

    def extra_fields=(value)
      
      if value.class.name != "Hash"
        raise(ThreeDeeCart::Exceptions::InvalidAttributeType, ThreeDeeCart::Exceptions::InvalidAttributeType::DEFAULT_MESSAGE % ["Extra fields", value.class])
      end

      if not value.nil?
        @extra_fields = value.values
      end

      @extra_fields
    end

    def price_levels=(value)
      if value.class.name != "Hash"
        raise(ThreeDeeCart::Exceptions::InvalidAttributeType, ThreeDeeCart::Exceptions::InvalidAttributeType::DEFAULT_MESSAGE % ["Price Levels", value.class])
      end

      if not value.nil?
        @price_levels = value.values
      end

      @price_levels
    end

    def images=(value)
      if value.class.name != "Array"
        raise(ThreeDeeCart::Exceptions::InvalidAttributeType, ThreeDeeCart::Exceptions::InvalidAttributeType::DEFAULT_MESSAGE % ["Images", value.class])
      end

      @images = []
      if not value.nil?
        value.each do |key, category|
          @images << ThreeDeeCart::Image.new(category)
        end
      end

      @images
    end

    def options=(value)
      if value.class.name != "Array"
        raise(ThreeDeeCart::Exceptions::InvalidAttributeType, ThreeDeeCart::Exceptions::InvalidAttributeType::DEFAULT_MESSAGE % ["Options", value.class])
      end

      @options = []
      if not value.nil?
        value.each do |key, option|
          @options << ThreeDeeCart::Option.new(option)
        end
      end

      @options
    end

    def keywords=(value)
      @keywords = value.split(',')
    end
  end
end
