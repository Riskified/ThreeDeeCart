require 'spec_helper'

describe ThreeDeeCart::Value do
  
  before(:all) do
    @valid_hash = {:id => "121", :name => "name1", :option_price => 22.5, :option_part_number => "one?"}
    @invalid_hash = {:id => "121", :name => "name1", :option_price => 22.5, :option_part_number => "one?", :invalid_key => true}
  end

  describe "#new" do
    it "should accept a valid hash to constructor" do
      lambda {
        @value = ThreeDeeCart::Value.new(@valid_hash)
      }.should_not raise_error(ThreeDeeCart::Exceptions::InvalidAttribute)
    end

    it "should raise an exception for invalid constructor hash value" do
      lambda {
        @value = ThreeDeeCart::Value.new(@invalid_hash)
      }.should raise_error(ThreeDeeCart::Exceptions::InvalidAttribute)
    end
  end  
end