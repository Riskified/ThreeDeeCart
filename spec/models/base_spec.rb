require 'spec_helper'
require 'fixtures/base_with_valid_attribute'

describe ThreeDeeCart::Base do

  describe "#new" do
    it "should not accept invalid attributes" do
      lambda {
        base = ThreeDeeCart::Base.new({invalid_attribute: true})
      }.should raise_error(ThreeDeeCart::Exceptions::InvalidAttribute)
    end

    it "should allow assignment of a valid, existing attribute" do
      @valid = nil
      lambda {
        @valid = BaseWithValidAttribute.new(valid_attribute: true)
      }.should_not raise_error

      @valid.valid_attribute.should eq(true)
    end
  end
end