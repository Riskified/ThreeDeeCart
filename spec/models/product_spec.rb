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
      expect(ThreeDeeCart::Product).to respond_to :find
    end

    it "should return as successful" do
      fixture = File.read("spec/fixtures/getProduct.xml")

      savon.expects(:get_product).with({message: {id: 1, userKey: "testtesttest"}}).returns(File.read("spec/fixtures/getProduct.xml"))
      product = ThreeDeeCart::Product.find({id: 1})
      expect(product.product_id).to eq("1001")
    end

    it "should return a valid product array for a valid request which returns multiple products" do
      fixture = File.read("spec/fixtures/getProduct.xml")

      savon.expects(:get_product).with({message: {id: 1, userKey: "testtesttest"}}).returns(File.read("spec/fixtures/getProductMultiple.xml"))
      product = ThreeDeeCart::Product.find({id: 1})
      expect(product[0].product_id).to eq("1001")
      expect(product[1].product_id).to eq("1001")
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
      expect(ThreeDeeCart::Product).to respond_to :count
    end

    it "should return as int when successful" do
      savon.expects(:get_product_count).with({message: {id: 1, userKey: "testtesttest"}}).returns(File.read("spec/fixtures/getProductCount.xml"))
      count = ThreeDeeCart::Product.count({id: 1})
      expect(count).to eq(6041)
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
      expect(ThreeDeeCart::Product).to respond_to :inventory_count
    end

    it "should return as int when successful" do
      savon.expects(:get_product_inventory).with({message: {id: 1, userKey: "testtesttest"}}).returns(File.read("spec/fixtures/getProductInventory.xml"))
      count = ThreeDeeCart::Product.inventory_count({id: 1})
      expect(count).to eq(10)
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
      expect(ThreeDeeCart::Product).to respond_to(:update_inventory)
    end

    it "should return a valid new inventory quantity" do
      savon.expects(:update_product_inventory).with({message: {quantity: 1, userKey: "testtesttest", replaceStock: true}}).returns(File.read("spec/fixtures/updateProductInventory.xml"))
      count = ThreeDeeCart::Product.update_inventory({quantity: 1, replaceStock: true})
      expect(count).to eq(1)
    end
  end

  describe "#new" do
    it "should accept a valid hash to constructor" do
      expect {
        @product = ThreeDeeCart::Product.new(@valid_hash)
      }.to_not raise_error
    end

    it "should raise an exception for invalid constructor hash value" do
      expect {
        @product = ThreeDeeCart::Product.new(@invalid_hash)
      }.to raise_error(ThreeDeeCart::Exceptions::InvalidAttribute)
    end

    describe "invalid values for complex enteties" do
      it "should raise an exception for invalid value for categories object" do
        expect {
          @product = ThreeDeeCart::Product.new(@hash_with_invalid_categories)
        }.to raise_error(ThreeDeeCart::Exceptions::InvalidAttributeType)
      end

      it "should raise an exception for invalid value for Extra Fields object" do
        expect {
          @product = ThreeDeeCart::Product.new(@hash_with_invalid_extra_fields)
        }.to raise_error(ThreeDeeCart::Exceptions::InvalidAttributeType)
      end

      it "should raise an exception for invalid value for price levels object" do
        expect {
          @product = ThreeDeeCart::Product.new(@hash_with_invalid_price_level)
        }.to raise_error(ThreeDeeCart::Exceptions::InvalidAttributeType)
      end

      it "should raise an exception for invalid value for eProduct object" do
        expect {
          @product = ThreeDeeCart::Product.new(@hash_with_invalid_e_product)
        }.to raise_error(ThreeDeeCart::Exceptions::InvalidAttributeType)
      end

      it "should raise an exception for invalid value for rewards object" do
        expect {
          @product = ThreeDeeCart::Product.new(@hash_with_invalid_rewards)
        }.to raise_error(ThreeDeeCart::Exceptions::InvalidAttributeType)
      end

      it "should raise an exception for invalid value for images object" do
        expect {
          @product = ThreeDeeCart::Product.new(@hash_with_invalid_images)
        }.to raise_error(ThreeDeeCart::Exceptions::InvalidAttributeType)
      end

      it "should raise an exception for invalid value for options object" do
        expect {
          @product = ThreeDeeCart::Product.new(@hash_with_invalid_options)
        }.to raise_error(ThreeDeeCart::Exceptions::InvalidAttributeType)
      end
    end
  end
end