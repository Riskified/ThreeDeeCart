require 'spec_helper'

describe ThreeDeeCart::Shipment do
  before(:all) do
    @valid_hash = {
      :shipment_id => 1,
      :shipment_date => "12/10/2013 12:29:39",
      :shipping => "0",
      :method => "Free Shipping",
      :weight => "0.00",
      :status => "New",
      :internal_comment => "",
      :tracking_code => "",
      :first_name => "John", 
      :last_name => "Doe",
      :address => "12th streetname",
      :address2 => "",
      :city => "New York City",
      :state_code => "NY",
      :zip_code => "123123",
      :country_code => "US",
      :company => "Testing Inc.",
      :phone => "9545454544"

    }
    @invalid_hash = {:invalid_key => true}
  end

  describe "#new" do
    it "should accept a valid hash to constructor" do
      expect {
        ThreeDeeCart::Shipment.new(@valid_hash)
      }.to_not raise_error
    end

    it "should raise an exception for invalid constructor hash value" do
      expect {
        ThreeDeeCart::Shipment.new(@invalid_hash)
      }.to raise_error(ThreeDeeCart::Exceptions::InvalidAttribute)
    end
  end

  describe "#full_name" do
    before(:each) do
      @shipment = ThreeDeeCart::Shipment.new(@valid_hash)
    end

    it "should respond to #full_name" do
      expect(@shipment).to respond_to :full_name
    end

    it "should return the full name" do
      expect(@shipment.full_name).to eq("John Doe")
    end
  end
end
