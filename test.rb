ThreeDeeCart.config do |config|
  config.wsdl = "http://api.3dcart.com/cart.asmx?WSDL"
  config.api_key = "27941608346427720279416083464277"
end

#AB-1000
#ThreeDeeCart::Customer.find({storeUrl: "riskified.3dcartstores.com", batchSize: 1, startNum: 1})
#ThreeDeeCart::Order.find({storeUrl: "riskified.3dcartstores.com", batchSize: 1, startNum: 1})
#ThreeDeeCart::Order.count({storeUrl: "riskified.3dcartstores.com"})
#ThreeDeeCart::Order.status({storeUrl: "riskified.3dcartstores.com", invoiceNum: "AB-1000"})
ThreeDeeCart::Order.update_status({storeUrl: "riskified.3dcartstores.com", invoiceNum: "AB-1000", newStatus: "Test"})
#ThreeDeeCart::Order.status({storeUrl: "riskified.3dcartstores.com", invoiceNum: "AB-1000"})
