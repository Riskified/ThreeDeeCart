  ThreeDeeCart.config do |config|
    config.wsdl = "http://api.3dcart.com/cart.asmx?WSDL"
   # config.api_key = "27941608346427720279416083464277"
  end

   #ThreeDeeCart::Order.count(storeUrl: "onetri.3dcartstores.com", userKey: "37366307182504920373663071825049")

   ThreeDeeCart::Order.find(storeUrl: "onetri.3dcartstores.com", 
                             userKey: "xxxx", 
                             startNum: 0,
                             batchSize: 50,
                             dateFrom: "08/10/2013",
                             status: "New")

   #AB-1000
# ThreeDeeCart::Order.find({storeUrl: 'riskified.3dcartstores.com', 
#                           userKey:'27941608346427720279416083464277',
#                           batchSize: 1,
#                           startNum: 1})
#ThreeDeeCart::Order.find({storeUrl: "riskified.3dcartstores.com", startNum: 0, batchSize: 10})
  #ThreeDeeCart::Order.update_shipment({storeUrl: "riskified.3dcartstores.com", invoiceNum: "AB-1000", tracking: "12312332", shipmentDate: "2013-07-18 15:08:30"})

  # test xml updated:

  #ThreeDeeCart::Order.find({storeUrl: "riskified.3dcartstores.com", batchSize: 1, startNum: 1})
  #ThreeDeeCart::Order.count({storeUrl: "riskified.3dcartstores.com"})
  #ThreeDeeCart::Order.status({storeUrl: "riskified.3dcartstores.com", invoiceNum: "AB-1000"})
  #ThreeDeeCart::Order.update_status({storeUrl: "riskified.3dcartstores.com", invoiceNum: "AB-1000", newStatus: "New"})

  #ThreeDeeCart::Customer.count({storeUrl: "riskified.3dcartstores.com"})
  #ThreeDeeCart::Customer.find({storeUrl: "riskified.3dcartstores.com", batchSize: 10, startNum: 0})
 # data = CustomerData.new(:action => :update, :contactid => "1", :email => "miki@blabla.com")
  #ThreeDeeCart::Customer.edit(data, {storeUrl: "riskified.3dcartstores.com"})
  #ThreeDeeCart::Product.find({storeUrl: "riskified.3dcartstores.com", batchSize: 1, startNum: 1})
  #ThreeDeeCart::Product.count({storeUrl: "riskified.3dcartstores.com"})
  #ThreeDeeCart::Product.inventory_count({storeUrl: "riskified.3dcartstores.com", :product_id => "1001"})
  #ThreeDeeCart::Product.update_inventory({storeUrl: "riskified.3dcartstores.com", :product_id => "1001", :quantity => 1, replaceStock: 1})
