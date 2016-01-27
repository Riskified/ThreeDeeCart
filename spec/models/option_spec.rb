require 'spec_helper'

describe ThreeDeeCart::Option do
  
  before(:all) do
    @valid_hash = {:id => "3434", :option_type => "cool", :values => {:value => [{}, {}]}}
    @valid_hash_with_invalid_value_type = {:id => "3434", :option_type => "cool", :values => "some values"}
    @invalid_hash = {:id => "3434", :option_type => "cool", :values => {:value => []}, :invalid_key => true}
  end

  describe "#new" do
    it "should accept a valid hash to constructor" do
      expect {
        @option = ThreeDeeCart::Option.new(@valid_hash)
      }.to_not raise_error
    end

    it "should raise an exception for invalid constructor hash value" do
      expect {
        @option = ThreeDeeCart::Option.new(@invalid_hash)
      }.to raise_error(ThreeDeeCart::Exceptions::InvalidAttribute)
    end

    it "should raise an exception for invalid values type" do
      expect {
        @option = ThreeDeeCart::Option.new(@valid_hash_with_invalid_value_type)
      }.to raise_error(ThreeDeeCart::Exceptions::InvalidAttributeType)
    end
  end  
end