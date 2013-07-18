require 'rubygems'
require 'three_dee_cart'


ThreeDeeCart.config do |config|
  config.wsdl = "http://api.3dcart.com/cart.asmx?WSDL"
  config.api_key = "27941608346427720279416083464277"
end


ThreeDeeCart::Customer.count({storeURL: "3dcart.riskified.com"})