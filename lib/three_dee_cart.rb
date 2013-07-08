
module ThreeDeeCart

  autoload :Config,   'three_dee_cart/config'
  autoload :Root,     'three_dee_cart/root'
  autoload :Base,     'three_dee_cart/base'
  autoload :Customer, 'three_dee_cart/customer'
  autoload :Address, 'three_dee_cart/address'
  autoload :BillingAddress, 'three_dee_cart/billing_address'
  autoload :ShippingAddress, 'three_dee_cart/shipping_address'
  autoload :Order, 'three_dee_cart/order'
  autoload :Transaction, 'three_dee_cart/transaction'
  autoload :AffiliateInformation, 'three_dee_cart/affiliate_information'
  autoload :Shipment, 'three_dee_cart/shipment'
  autoload :Item, 'three_dee_cart/item'
  autoload :Version,  "three_dee_cart/version"

  @@configuration = nil

  def self.load_configuration(config_file)
    @@configuration = ThreeDeeCart::Config.load_configuration_from_file(config_file)
  end

  def self.config(&block)
    @@configuration = yield(ThreeDeeCart::Config)
  end

  def self.configuration
    @@configuration
  end

  def self.client
    @@client ||= Savon.client(wsdl: self.configuration.wsdl)
  end
end
