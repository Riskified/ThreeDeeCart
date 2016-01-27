require 'spec_helper'

describe ThreeDeeCart::Category do
  
  before(:all) do
    @valid_hash = {:category_id => "121", :category_name => "name1"}
    @invalid_hash = {:category_id => "121", :category_name => "name1", :invald_key => true}
  end

  describe "#new" do
    it "should accept a valid hash to constructor" do
      expect {
        @category = ThreeDeeCart::Category.new(@valid_hash)
      }.not_to raise_error
    end

    it "should raise an exception for invalid constructor hash value" do
      expect {
        @category = ThreeDeeCart::Category.new(@invalid_hash)
      }.to raise_error(ThreeDeeCart::Exceptions::InvalidAttribute)
    end
  end  
end