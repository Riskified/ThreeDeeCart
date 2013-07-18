ThreeDeeCart.config do |config|
  config.wsdl = "http://api.3dcart.com/cart.asmx?WSDL"
  config.api_key = "27941608346427720279416083464277"
end


#ThreeDeeCart::Customer.find({storeUrl: "riskified.3dcartstores.com", batchSize: 1, startNum: 1})
ThreeDeeCart::Order.find({storeUrl: "riskified.3dcartstores.com", batchSize: 1, startNum: 1})