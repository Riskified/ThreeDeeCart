require 'spec_helper'

describe ThreeDeeCart::Address do
  before(:all) do
    @valid_hash = {:first_name => "John", 
                   :last_name => "Doe",
                   :address => "12th streetname",
                   :address2 => "",
                   :city => "New York City",
                   :state_code => "NY",
                   :zip_code => "123123",
                   :country_code => "US",
                   :company => "Testing Inc.",
                   :phone => "9545454544"}
                   
    @invalid_hash = {:invalid_attribute => true}
  end

  describe "#new" do
    it "should accept a valid hash into constructor" do
      lambda {
        @address = ThreeDeeCart::Address.new(@valid_hash)
      }.should_not raise_error
    end

    it "should raise an exception for invalid constractor hash" do
      lambda {
        @address = ThreeDeeCart::Address.new(@invalid_hash)
      }.should raise_error(ThreeDeeCart::Exceptions::InvalidAttribute)
    end
  end

  describe "#full_name" do
    it "should return a full name" do
      @billing_address = ThreeDeeCart::Address.new(@valid_hash)
      @billing_address.full_name.should eql("John Doe")
    end
  end
end