=begin
Represents the 3D Cart Category response object
=end
module ThreeDeeCart
  class Category < ThreeDeeCart::Root
    attr_accessor :category_id
    attr_accessor :category_name
  end
end