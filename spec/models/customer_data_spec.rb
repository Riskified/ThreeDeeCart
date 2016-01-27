require 'spec_helper'

describe ThreeDeeCart::CustomerData do

  describe "#new" do
    it "should not allow object if a contactid is missing" do
      @customer_data = ThreeDeeCart::CustomerData.new()
      expect(@customer_data.valid?).to be false
      expect(@customer_data.attributes).to eq({})
    end

    it "should allow a valid object if contactid exists and action is not :insert" do
      @customer_data = ThreeDeeCart::CustomerData.new({contactid: "1", action: :update})
      @customer_data.valid?
      expect(@customer_data.errors).to be_empty
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
      expect(@customer_data.errors).not_to be_empty
      expect(@customer_data.errors[:billing_firstname]).to eq(["can't be blank"])
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
      expect(@customer_data.errors).to be_empty
    end
  end

  describe "#insert?" do
    it "should return true if action is :insert" do
      @customer_data = ThreeDeeCart::CustomerData.new({:action => :insert})
      expect(@customer_data.insert?).to be true
    end

    it "should return false if action is not :insert" do
      @customer_data = ThreeDeeCart::CustomerData.new({:action => :update})
      expect(@customer_data.insert?).to be false
    end
  end

  describe "update?" do
    it "should return true if action is :update" do
      @customer_data = ThreeDeeCart::CustomerData.new({:action => :update})
      expect(@customer_data.update?).to be true
    end

    it "should return false if action is not :update" do
      @customer_data = ThreeDeeCart::CustomerData.new({:action => :insert})
      expect(@customer_data.update?).to be false
    end
  end

  describe "delete?" do
    it "should return true if action is :delete" do
      @customer_data = ThreeDeeCart::CustomerData.new({:action => :delete})
      expect(@customer_data.delete?).to be true
    end

    it "should retun false if action is not :delete" do
      @customer_data = ThreeDeeCart::CustomerData.new({:action => :update})
      expect(@customer_data.delete?).to be false
    end
  end

  describe "#attributes" do

    it "should reflect current set attributes from construstor" do
      @customer_data = ThreeDeeCart::CustomerData.new({contactid: "1", email: "elad@testing.com"})
      expect(@customer_data.attributes).to eq({contactid: "1", email: "elad@testing.com"})
    end

    it "should not reflect the :action attribute in the attributes hash" do
      @customer_data = ThreeDeeCart::CustomerData.new({contactid: "1", email: "elad@testing.com", action: :insert})
      expect(@customer_data.attributes).to eq({contactid: "1", email: "elad@testing.com"})
    end

    it "shold reflect changes to setter" do
      @customer_data = ThreeDeeCart::CustomerData.new({contactid: "1", email: "elad@testing.com"})
      expect(@customer_data.attributes[:contactid]).to eq("1")
      @customer_data.contactid = "3"
      expect(@customer_data.attributes[:contactid]).to eq("3")
    end
  end

  describe "#to_query" do
    it "should return a valid string per API's demand for valid request" do
      @customer_data = ThreeDeeCart::CustomerData.new({contactid: "1", email: "elad@testing.com", action: :update})
      expect(@customer_data.to_query).to eq("contactid===1|||email===elad@testing.com")
    end

    it "shoudl raise an error for an invalid instance" do
      @customer_data = ThreeDeeCart::CustomerData.new({email: "elad@testing.com", action: :update})
      expect {
        @customer_data.to_query
      }.to raise_error(ThreeDeeCart::CustomerData::Exceptions::QueryConversionError)
    end
  end
end