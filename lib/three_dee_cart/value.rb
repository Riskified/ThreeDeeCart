=begin
Represents the 3D Cart Value response object
=end
module ThreeDeeCart
  class Value < ThreeDeeCart::Root
    attr_accessor :id
    attr_accessor :name
    attr_accessor :option_price
    attr_accessor :option_part_number
  end
end
