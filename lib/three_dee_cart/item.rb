module ThreeDeeCart
  class Item < ThreeDeeCart::Root
    attr_accessor :shipment_id
    attr_accessor :warehouse_id
    attr_accessor :product_id
    attr_accessor :product_name
    attr_accessor :quantity
    attr_accessor :unit_price
    attr_accessor :unit_cost
    attr_accessor :option_price
    attr_accessor :weight
    attr_accessor :date_added
    attr_accessor :page_added
  end
end