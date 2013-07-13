require 'spec_helper'

describe ThreeDeeCart::BillingAddress do
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
                   :phone => "9545454544",
                   :email => "test@testinginc.com"}
  end

  describe "#email" do
    it "should respond to #email" do
      @billing_address = ThreeDeeCart::BillingAddress.new(@valid_hash)
      @billing_address.respond_to?(:email).should be_true
    end
  end
end