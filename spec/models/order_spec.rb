require 'spec_helper'
require "savon/mock/spec_helper"

describe ThreeDeeCart::Order do
  include Savon::SpecHelper

  before(:all) { 
    savon.mock!
    ThreeDeeCart.load_configuration("spec/fixtures/test_config.yml")
  
    nori_options = {
      :strip_namespaces     => true,
      :convert_tags_to      => lambda { |tag| tag.snakecase.to_sym },
      :advanced_typecasting => true,
      :parser               => :nokogiri
    }
    doc = File.read("spec/fixtures/getOrder.xml")
    @valid_hash = Nori.new(nori_options).parse(doc)[:get_orders_response][:order]
  }
  
  after(:all)  { savon.unmock! }

  describe "#new" do
    it "should accept a valid hash to constructor" do
      lambda {
        ThreeDeeCart::Order.new(@valid_hash)
      }.should_not raise_error
    end
  end
end