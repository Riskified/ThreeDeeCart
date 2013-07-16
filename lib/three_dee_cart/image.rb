=begin
Represents the 3D Cart Image response object
=end
module ThreeDeeCart
  
  class Image < ThreeDeeCart::Root

    ALLOWED_IMAGE_TYPES = ["jpg", "jpeg", "png", "gif", "bmp", "tiff", "tif"]
    
    attr_accessor :url
    attr_accessor :caption

    # Return the image type per the API response url. consider allowed images hash.
    def image_type
      @image_type = File.extname(self.url).gsub(".", "").downcase

      if ALLOWED_IMAGE_TYPES.include?(@image_type)
        @image_type.to_sym
      else
        :unknown
      end
    end
  end
end