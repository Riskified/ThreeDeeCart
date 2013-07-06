require 'spec_helper'

describe ThreeDeeCart::Customer do

  describe "#get_customer" do
    ThreeDeeCart::Customer.get_customer(3)
  end
end