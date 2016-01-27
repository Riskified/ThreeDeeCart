require 'spec_helper'
require 'fixtures/base_with_valid_attribute'

describe ThreeDeeCart::Base do

  describe "#new" do
    it "should not accept invalid attributes" do
      expect {
        base = ThreeDeeCart::Base.new({invalid_attribute: true})
      }.to raise_error(ThreeDeeCart::Exceptions::InvalidAttribute)
    end

    it "should allow assignment of a valid, existing attribute" do
      @valid = nil
      expect {
        @valid = BaseWithValidAttribute.new(valid_attribute: true)
      }.to_not raise_error

      expect(@valid.valid_attribute).to eq(true)
    end
  end
end