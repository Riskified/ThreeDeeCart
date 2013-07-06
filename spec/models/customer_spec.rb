require 'spec_helper'
require "savon/mock/spec_helper"

describe ThreeDeeCart::Customer do

  include Savon::SpecHelper
  
  # set Savon in and out of mock mode
  before(:all) { 
    savon.mock!   
    ThreeDeeCart.load_configuration("spec/fixtures/test_config.yml")
  }
  after(:all)  { savon.unmock! }

  describe "#find" do
    it "should respond to #find" do
      ThreeDeeCart::Customer.respond_to?(:find).should eq(true)
    end

    it "should return as successful" do
      fixture = File.read("spec/fixtures/getCustomer.xml")
      savon.expects(:get_customer).with({id: 1}).returns(fixture)

      user = ThreeDeeCart::Customer.find({id: 1})

      expect(user).to be_successful
    end
  end
end