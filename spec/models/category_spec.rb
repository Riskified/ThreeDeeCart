require 'spec_helper'

describe ThreeDeeCart::Category do
  
  before(:all) do
    @valid_hash = {:category_id => "121", :category_name => "name1"}
    @invalid_hash = {:category_id => "121", :category_name => "name1", :invald_key => true}
  end

  describe "#new" do
    it "should accept a valid hash to constructor" do
      lambda {
        @category = ThreeDeeCart::Category.new(@valid_hash)
      }.should_not raise_error(ThreeDeeCart::Exceptions::InvalidAttribute)
    end

    it "should raise an exception for invalid constructor hash value" do
      lambda {
        @category = ThreeDeeCart::Category.new(@invalid_hash)
      }.should raise_error(ThreeDeeCart::Exceptions::InvalidAttribute)
    end
  end  
end