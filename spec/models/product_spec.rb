require 'spec_helper'

describe ThreeDeeCart::Product do
  include Savon::SpecHelper
  
  # set Savon in and out of mock mode
  before(:all) do
    savon.mock!
    ThreeDeeCart.load_configuration("spec/fixtures/test_config.yml")
  
    @valid_hash = {
    :product_id => "123",
    :product_name => "Cool product",
    :mfgid => 1234,
    :manufacturer => "Tralala",
    :distributor => "talal",
    :cost => 100.5,
    :price => 80,
    :retail_price => 200,
    :sale_price => 150,
    :on_sale => false,
    :stock => 5,
    :stock_alert => 1,
    :weight => 20,
    :width => 100,
    :height => 200,
    :depth => 300,
    :minimum_order => 1,
    :maximum_order => 2,
    :date_created => "10/10/2010",
    :description => "Really good product",
    :extended_description => "Extendly really good product",
    :ship_cost => 20,
    :title => "Coolio",
    :display_text => "Coolio text",
    :home_special => "huh?",
    :category_special => "category special",
    :hide => false,
    :free_shipping => false,
    :non_tax => false,
    :not_forsale => false,
    :gift_certificate => "blabla",
    :user_id => "2",
    :last_update => "10/10/2013",
    :min_order => 1,
    :listing_display_type => "3",
    :show_out_stock => false,
    :pricing_group_opt => "pricing group",
    :quantity_discount_opt => "none",
    :login_level => "1",
    :redirect_to => "www.google.com",
    :access_group => "access group",
    :self_ship => false,
    :tax_code => "3",
    :non_searchable => false,
    :instock_message => "instock",
    :out_of_stock_message => "out of stock",
    :back_order_message => "on back order",
    :thumbnail => "www.test.com/funimg.jpg",
    :file_name => "funimg.jpg",
    :use_catoptions => false,
    :quantity_options => "bldfldslf",
    :categories => {:category => [{}, {}]},
    :extra_fields => {},
    :price_level => {},
    :e_product => {},
    :rewards => {},
    :images => {:image => [{}, {}]},
    :options => {:option => [{}, {}]},
    :keywords => "key1, key2",
    :related_products => [],
    :meta_tags => [],
    }

    @invalid_hash = @valid_hash.merge(:invalid_key => true)

    @hash_with_invalid_categories = @valid_hash.merge(:categories => "string")
    @hash_with_invalid_extra_fields = @valid_hash.merge(:extra_fields => "string")
    @hash_with_invalid_price_level = @valid_hash.merge(:price_level => "string")
    @hash_with_invalid_e_product = @valid_hash.merge(:e_product => "string")
    @hash_with_invalid_rewards = @valid_hash.merge(:rewards => "string")
    @hash_with_invalid_images = @valid_hash.merge(:images => "string")
    @hash_with_invalid_options = @valid_hash.merge(:options => "string")
  end

  after(:all)  { savon.unmock! }

  describe "#find" do
    before(:each) do
      FakeWeb.register_uri(:get, "http://example.com/?wsdl", :body => File.read("spec/fixtures/wsdl_mock.xml"))
    end

    after(:each) do
      FakeWeb.clean_registry
    end

    it "should respond to #find" do
      ThreeDeeCart::Product.respond_to?(:find).should eq(true)
    end

    it "should return as successful" do
      fixture = File.read("spec/fixtures/getProduct.xml")

      savon.expects(:get_product).with({message: {id: 1, userKey: "testtesttest"}}).returns(File.read("spec/fixtures/getProduct.xml"))
      product = ThreeDeeCart::Product.find({id: 1})
    end
  end

  describe "#count" do
    before(:each) do
      FakeWeb.register_uri(:get, "http://example.com/?wsdl", :body => File.read("spec/fixtures/wsdl_mock.xml"))
    end

    after(:each) do
      FakeWeb.clean_registry
    end

    it "should respond to #count" do
      ThreeDeeCart::Product.respond_to?(:count).should eq(true)
    end

    it "should return as int when successful" do
      savon.expects(:get_product_count).with({message: {id: 1, userKey: "testtesttest"}}).returns(File.read("spec/fixtures/getProductCount.xml"))
      count = ThreeDeeCart::Product.count({id: 1})
      count.should eq(6041)
    end
  end

  describe "#inventory_count" do
    before(:each) do
      FakeWeb.register_uri(:get, "http://example.com/?wsdl", :body => File.read("spec/fixtures/wsdl_mock.xml"))
    end

    after(:each) do
      FakeWeb.clean_registry
    end

    it "should respond to #inventory_count" do
      ThreeDeeCart::Product.respond_to?(:inventory_count).should eq(true)
    end

    it "should return as int when successful" do
      savon.expects(:get_product_inventory).with({message: {id: 1, userKey: "testtesttest"}}).returns(File.read("spec/fixtures/getProductInventory.xml"))
      count = ThreeDeeCart::Product.inventory_count({id: 1})
      count.should eq(10)
    end
  end

  describe "#update_inventory" do
    before(:each) do
      FakeWeb.register_uri(:get, "http://example.com/?wsdl", :body => File.read("spec/fixtures/wsdl_mock.xml"))
    end

    after(:each) do
      FakeWeb.clean_registry
    end

    it "should respond to #update_inventory" do
      ThreeDeeCart::Product.should respond_to(:update_inventory)
    end

    it "should return a valid new inventory quantity" do
      savon.expects(:update_product_inventory).with({message: {quantity: 1, userKey: "testtesttest"}}).returns(File.read("spec/fixtures/updateProductInventory.xml"))
      count = ThreeDeeCart::Product.update_inventory({quantity: 1})
      count.should eq(50)
    end
  end

  describe "#new" do
    it "should accept a valid hash to constructor" do
      lambda {
        @product = ThreeDeeCart::Product.new(@valid_hash)
      }.should_not raise_error(ThreeDeeCart::Exceptions::InvalidAttribute)
    end

    it "should raise an exception for invalid constructor hash value" do
      lambda {
        @product = ThreeDeeCart::Product.new(@invalid_hash)
      }.should raise_error(ThreeDeeCart::Exceptions::InvalidAttribute)
    end

    describe "invalid values for complex enteties" do
      it "should raise an exception for invalid value for categories object" do 
        lambda {
          @product = ThreeDeeCart::Product.new(@hash_with_invalid_categories)
        }.should raise_error(ThreeDeeCart::Exceptions::InvalidAttributeType)
      end

      it "should raise an exception for invalid value for Extra Fields object" do 
        lambda {
          @product = ThreeDeeCart::Product.new(@hash_with_invalid_extra_fields)
        }.should raise_error(ThreeDeeCart::Exceptions::InvalidAttributeType)
      end

      it "should raise an exception for invalid value for price levels object" do 
        lambda {
          @product = ThreeDeeCart::Product.new(@hash_with_invalid_price_level)
        }.should raise_error(ThreeDeeCart::Exceptions::InvalidAttributeType)
      end

      it "should raise an exception for invalid value for eProduct object" do 
        lambda {
          @product = ThreeDeeCart::Product.new(@hash_with_invalid_e_product)
        }.should raise_error(ThreeDeeCart::Exceptions::InvalidAttributeType)
      end

      it "should raise an exception for invalid value for rewards object" do 
        lambda {
          @product = ThreeDeeCart::Product.new(@hash_with_invalid_rewards)
        }.should raise_error(ThreeDeeCart::Exceptions::InvalidAttributeType)
      end

      it "should raise an exception for invalid value for images object" do 
        lambda {
          @product = ThreeDeeCart::Product.new(@hash_with_invalid_images)
        }.should raise_error(ThreeDeeCart::Exceptions::InvalidAttributeType)
      end

      it "should raise an exception for invalid value for options object" do 
        lambda {
          @product = ThreeDeeCart::Product.new(@hash_with_invalid_options)
        }.should raise_error(ThreeDeeCart::Exceptions::InvalidAttributeType)
      end
    end
  end
end