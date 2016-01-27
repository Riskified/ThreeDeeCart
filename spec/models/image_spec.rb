require 'spec_helper'

describe ThreeDeeCart::Image do
  
  before(:all) do
    @valid_hash = {"url" => "http://images.com/test.jpg", "caption" => "test image"}
    @hash_with_invalid_image = {"url" => "http://images.com", "caption" => "unknown image"}
    @invalid_hash = {"url" => "http://image.com/test.jpg", "caption" => "test image", "invalid_key" => true}
  end

  describe "#new" do
    it "should accept a valid hash to constructor" do
      expect {
        @image = ThreeDeeCart::Image.new(@valid_hash)
      }.to_not raise_error
    end

    it "should raise an exception for invalid constructor hash value" do
      expect {
        @image = ThreeDeeCart::Image.new(@invalid_hash)
      }.to raise_error(ThreeDeeCart::Exceptions::InvalidAttribute)
    end
  end  

  describe "#image_type" do
    it "should respond to #image_type" do
      expect(ThreeDeeCart::Image.new(@valid_hash)).to respond_to :image_type
    end

    it "should return the right image type" do    
      @image = ThreeDeeCart::Image.new(@valid_hash)
      expect(@image.image_type).to eq(:jpg)
    end

    it "should return :unknown for unknown image type" do
      @invalid_image_type = ThreeDeeCart::Image.new(@hash_with_invalid_image)
      expect(@invalid_image_type.image_type).to eq(:unknown)
    end
  end
  
end