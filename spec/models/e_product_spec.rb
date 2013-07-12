require 'spec_helper'

describe ThreeDeeCart::EProduct do
  
  before(:all) do
         
    @valid_hash = {:e_product_password => "123123", :e_product_random => "dfsdgdf", :e_product_expire => "01/01/2014", :e_product_path => "/root/dir/", :e_product_serial => "s123", :e_product_instructions => "some instructions here", :e_product_reuse_serial => "s1234"}
    @invalid_hash = {:e_product_password => "123123", :e_product_random => "dfsdgdf", :e_product_expire => "01/01/2014", :e_product_path => "/root/dir/", :e_product_serial => "s123", :e_product_instructions => "some instructions here", :e_product_reuse_serial => "s1234", :invalid_key => true}
  end

  describe "#new" do
    it "should accept a valid hash to constructor" do
      lambda {
        @option = ThreeDeeCart::EProduct.new(@valid_hash)
      }.should_not raise_error(ThreeDeeCart::Exceptions::InvalidAttribute)
    end

    it "should raise an exception for invalid constructor hash value" do
      lambda {
        @option = ThreeDeeCart::EProduct.new(@invalid_hash)
      }.should raise_error(ThreeDeeCart::Exceptions::InvalidAttribute)
    end
  end  
end