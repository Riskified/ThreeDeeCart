=begin
Represents the 3D Cart Billing Address response object
=end
module ThreeDeeCart
  class BillingAddress < ThreeDeeCart::Address
    attr_accessor :email
  end
end