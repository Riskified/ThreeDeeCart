=begin
Represents the 3D Cart Transaction response object
=end
module ThreeDeeCart
  class Transaction < ThreeDeeCart::Root
    attr_accessor :transaction_id
    attr_accessor :cvv2
    attr_accessor :response_text
    attr_accessor :avs
    attr_accessor :approval_code
    attr_accessor :transaction_type
    attr_accessor :amount
  end
end