module ThreeDeeCart
  class Address < ThreeDeeCart::Root
    attr_accessor :firstName
    attr_accessor :lastName
    attr_accessor :address
    attr_accessor :address2
    attr_accessor :city
    attr_accessor :stateCode
    attr_accessor :zipCode
    attr_accessor :countryCode
    attr_accessor :company
    attr_accessor :phone
  end
end