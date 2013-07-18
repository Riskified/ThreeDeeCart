ThreeDeeCart.config do |config|
  config.wsdl = "http://api.3dcart.com/cart.asmx?WSDL"
  config.api_key = "27941608346427720279416083464277"
end

#AB-1000

ThreeDeeCart::Order.update_shipment({storeUrl: "riskified.3dcartstores.com", invoiceNum: "AB-1000", tracking: "12312332", shipmentDate: "2013-07-18 15:08:30"})

# test xml updated:

#ThreeDeeCart::Order.find({storeUrl: "riskified.3dcartstores.com", batchSize: 1, startNum: 1})
#ThreeDeeCart::Order.count({storeUrl: "riskified.3dcartstores.com"})
#ThreeDeeCart::Order.status({storeUrl: "riskified.3dcartstores.com", invoiceNum: "AB-1000"})
#ThreeDeeCart::Order.update_status({storeUrl: "riskified.3dcartstores.com", invoiceNum: "AB-1000", newStatus: "New"})

#ThreeDeeCart::Customer.count({storeUrl: "riskified.3dcartstores.com"})
#ThreeDeeCart::Customer.find({storeUrl: "riskified.3dcartstores.com", batchSize: 1, startNum: 1})
#ThreeDeeCart::Product.find({storeUrl: "riskified.3dcartstores.com", batchSize: 1, startNum: 1})
#ThreeDeeCart::Product.count({storeUrl: "riskified.3dcartstores.com"})
#ThreeDeeCart::Product.inventory_count({storeUrl: "riskified.3dcartstores.com", :product_id => "1001", :quantity => 1, replaceStock: 1})
