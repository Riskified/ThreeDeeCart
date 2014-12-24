=begin
Represents the 3D Cart Item response object
=end
module ThreeDeeCart
  class Item < ThreeDeeCart::Root
    attr_accessor :shipment_id
    attr_accessor :warehouse_id
    attr_accessor :product_id
    attr_accessor :product_name
    attr_accessor :quantity
    attr_accessor :item_price
    attr_accessor :unit_price
    attr_accessor :unit_cost
    attr_accessor :item_cost
    attr_accessor :total
    attr_accessor :option_price
    attr_accessor :weight
    attr_accessor :dimension
    attr_accessor :prod_type
    attr_accessor :taxable
    attr_accessor :date_added
    attr_accessor :page_added
    attr_accessor :gift_certificate_code

    # Getter for product name
    def name
      @product_name
    end

    # float getter for unit price
    def price
      unit_price.to_f
    end

    # float getter for unit cost
    def cost
      unit_cost.to_f
    end

    # float getter for option price
    def option_price
      @option_price.to_f
    end
  end
end