require 'spec_helper'

describe ThreeDeeCart::Rewards do
  
  before(:all) do
    @valid_hash = {:reward_points => 100, :reward_disable => false, :reward_redeem => true}
    @invalid_hash = {:reward_points => 100, :reward_disable => false, :reward_redeem => true, :invalid_key => true}
  end

  describe "#new" do
    it "should accept a valid hash to constructor" do
      lambda {
        @rewards = ThreeDeeCart::Rewards.new(@valid_hash)
      }.should_not raise_error(ThreeDeeCart::Exceptions::InvalidAttribute)
    end

    it "should raise an exception for invalid constructor hash value" do
      lambda {
        @rewards = ThreeDeeCart::Rewards.new(@invalid_hash)
      }.should raise_error(ThreeDeeCart::Exceptions::InvalidAttribute)
    end
  end  
end