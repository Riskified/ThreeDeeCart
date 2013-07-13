module ThreeDeeCart
  class Address < ThreeDeeCart::Root
    attr_accessor :first_name
    attr_accessor :last_name
    attr_accessor :address
    attr_accessor :address2
    attr_accessor :city
    attr_accessor :state_code
    attr_accessor :zip_code
    attr_accessor :country_code
    attr_accessor :company
    attr_accessor :phone

    def full_name
      [first_name, last_name].compact.join(" ")
    end
  end
end