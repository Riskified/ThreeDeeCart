require 'spec_helper'

describe ThreeDeeCart::CustomerData do

  describe "#new" do
    it "should not allow object if a contactid is missing" do
      @customer_data = ThreeDeeCart::CustomerData.new()
      @customer_data.valid?.should be_false
      @customer_data.attributes.should eq({})
    end

    it "should allow a valid object if contactid exists and action is not :insert" do
      @customer_data = ThreeDeeCart::CustomerData.new({contactid: "1", action: :update})
      @customer_data.valid?
      @customer_data.errors.should be_empty
    end

    it "should not allow and :insert customer data without required fields (billing_firstname missing)" do
      @customer_data = ThreeDeeCart::CustomerData.new({
        contactid: "1",
        action: :insert,
        #billing_firstname: "elad",
        billing_lastname: "meidar",
        email: "elad@testing.com",
        pass: "ahorsewithashow"
        })

      @customer_data.valid?
      @customer_data.errors.should_not be_empty
      @customer_data.errors[:billing_firstname].should eq(["can't be blank"])
    end

    it "should allow an :insert customer data with all requried fields" do
      @customer_data = ThreeDeeCart::CustomerData.new({
        contactid: "1",
        action: :insert,
        billing_firstname: "elad",
        billing_lastname: "meidar",
        email: "elad@testing.com",
        pass: "ahorsewithashow"
        })

      @customer_data.valid?
      @customer_data.errors.should be_empty
    end
  end

  describe "#insert?"
  describe "#attributes" do

    it "should reflect current set attributes from construstor" do
      @customer_data = ThreeDeeCart::CustomerData.new({contactid: "1", email: "elad@testing.com"})
      @customer_data.attributes.should eq({contactid: "1", email: "elad@testing.com"})
    end

    it "should not reflect the :action attribute in the attributes hash" do
      @customer_data = ThreeDeeCart::CustomerData.new({contactid: "1", email: "elad@testing.com", action: :insert})
      @customer_data.attributes.should eq({contactid: "1", email: "elad@testing.com"})
    end

    it "shold reflect changes to setter" do
      @customer_data = ThreeDeeCart::CustomerData.new({contactid: "1", email: "elad@testing.com"})
      @customer_data.attributes[:contactid].should eq("1")
      @customer_data.contactid = "3"
      @customer_data.attributes[:contactid].should eq("3")
    end
  end

end